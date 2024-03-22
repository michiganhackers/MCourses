//
//  AuthViewModel.swift
//  Celly
//
//  Created by Finn on 8/9/23.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    func signInGoogle() async throws {
        let helper = GoogleSignInHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try UserManager.shared.createNewUser(user: user)
    }
}
