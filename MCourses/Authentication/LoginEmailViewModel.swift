//
//  LoginEmailViewModel.swift
//  MCourses
//
//  Created by Finn on 8/9/23.
//

import Foundation

@MainActor
final class LoginEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    func signUp() async throws {
        // implement validation later
        guard !email.isEmpty,
              !password.isEmpty else {
            print("No email or no password found.")
            return
        }
        let authDataResult = try await AuthManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try UserManager.shared.createNewUser(user: user)
    }
    
    func signIn() async throws {
        // implement validation later
        guard !email.isEmpty,
              !password.isEmpty else {
            print("No email or no password found.")
            return
        }
        try await AuthManager.shared.signInUser(email: email, password: password)
    }
}
