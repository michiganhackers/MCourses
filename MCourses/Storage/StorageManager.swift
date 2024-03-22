//
//  StorageManager.swift
//  MCourses
//
//  Created by Finn on 8/12/23.
//

import Foundation
import FirebaseStorage
import UIKit

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }
    
    func getData(userId: String, path: String) async throws -> Data {
        try await storage.child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
    func getImagePath(path: String) -> StorageReference {
        Storage.storage().reference(withPath: path)
    }
    
    func getImageURL(path: String) async throws -> URL {
        try await getImagePath(path: path).downloadURL()
    }
    
    func getImage(userId: String, path: String) async throws -> UIImage {
        let data = try await getData(userId: userId, path: path)
        guard let image = UIImage(data: data) else {
            //TODO: can't conver data into image
            throw URLError(.badURL)
        }
        return image
    }
    
    func saveImage(data: Data, userId: String) async throws -> (path: String, name: String){
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await userReference(userId: userId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedName = returnedMetaData.name, let returnedPath = returnedMetaData.path else {
            throw URLError(.badServerResponse)
        }
        return (returnedPath, returnedName)
    }
    // more often than not, you will get a UIImage rather than "data" like with our current photo picker
    func saveImage(image: UIImage, userId: String) async throws -> (path: String, name: String){
        // compression quality 1 means no compression
        guard let data = image.jpegData(compressionQuality: 1) else {
            // TODO: error: can't conver image to jpeg
            throw URLError(.badURL)
        }
        return try await saveImage(data: data, userId: userId)
    }
    
    func deleteImage(path: String) async throws {
        try await getImagePath(path: path).delete()
    }
}
