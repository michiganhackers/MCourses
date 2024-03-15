//
//  UserManager.swift
//  Celly
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
    
//    func addPost(userId: String, post: Post) async throws {
//        let data: [String:Any] = [
//            Post.CodingKeys.postId.rawValue : post.postId,
//            Post.CodingKeys.ownerUID.rawValue : post.ownerUID,
//            Post.CodingKeys.caption.rawValue : post.caption,
//            //Post.CodingKeys.cellies.rawValue : post.cellies,
//            //Post.CodingKeys.postImageURL.rawValue : post.postImageURL,
//            Post.CodingKeys.datePosted.rawValue : post.datePosted,
//            Post.CodingKeys.dateCompleted.rawValue : post.dateCompleted
//        ]
//        try await userDocument(userId: userId).collection("posts").document(post.postId).setData(data) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Post successfully written!")
//            }
//        }
//    }
//    
//    func removePost(userId: String, post: Post) async throws {
//        try await userDocument(userId: userId).collection("posts").document(post.postId).delete()
//    }
}
