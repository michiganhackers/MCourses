//
//  AuthManager.swift
//  Celly
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
