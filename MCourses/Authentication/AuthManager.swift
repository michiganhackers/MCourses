//
//  AuthManager.swift
//  MCourses
//
//  Created by Finn on 7/26/23.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

enum AuthProviderType: String {
    case email = "password"
    case google = "google.com"
}

final class AuthManager {
    static let shared = AuthManager()
    private init() { }
    
    func getUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            // create custom error for no user
            throw URLError(.badURL)
        }
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        try await user.delete()
    }
    
    func getProviders() throws -> [AuthProviderType]{
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badURL)
        }
        var providers: [AuthProviderType] = []
        for provider in providerData {
            if let option = AuthProviderType(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }
}

// MARK: SIGN IN EMAIL
extension AuthManager {
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            // CUSTOM ERROR
            throw URLError(.badURL)
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            // CUSTOM ERROR
            throw URLError(.badURL)
        }
        try await user.updateEmail(to: email)
    }
    
    //TODO: (LOW PRIORITY): Update Password, Update email for user, etc.
}



// MARK: SIGN IN GOOGLE
extension AuthManager {
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}

// MARK: SIGN IN FACEBOOK
//extension AuthManager {
//    func signInWithFacebook() -> AuthDataResultModel {
//
//    }
//}
