//
//  ProfileViewModel.swift
//  MCourses
//
//  Created by Finn on 8/12/23.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthManager.shared.getUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func saveProfileImage(item: PhotosPickerItem) throws {
        guard let user else { return }
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, name) = try await StorageManager.shared.saveImage(data: data, userId: user.userId)
            print("SUCCESS")
            print(path)
            print(name)
            let url = try await StorageManager.shared.getImageURL(path: path)
            try await UserManager.shared.updateProfileImage(userId: user.userId, path: path, url: url.absoluteString)
        }
    }
    
    func deleteProfileImage() {
        guard let user, let path = user.profileImagePath else { return }
        Task {
            print("deleteProfileImage() UserID: \(user.userId), Path: \(path)")
            try await StorageManager.shared.deleteImage(path: path)
            try await UserManager.shared.updateProfileImage(userId: user.userId, path: nil, url: nil)
        }
    }
}
