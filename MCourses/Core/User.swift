//
//  User.swift
//  MCourses
//
//  Created by Finn Moore on 4/15/24.
//
import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    
    let email: String
    let profileImageURL: String
    
    var fullName: String
    
    var isCurrentUser: Bool {
        Auth.auth().currentUser?.uid == id
    }
}
