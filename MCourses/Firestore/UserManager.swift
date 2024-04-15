//
//  UserManager.swift
//  MCourses
//
//  Created by Finn on 8/9/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        return decoder
    }()
    
    func createNewUser(user: DBUser) throws {
        try userDocument(userId: user.userId).setData(from: user)
    }
     
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func updateProfileImage(userId: String, path: String?, url: String?) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.profileImageURLString.rawValue : url,
            DBUser.CodingKeys.profileImagePath.rawValue : path
        ]
        try await userDocument(userId: userId).updateData(data)
    }

}
