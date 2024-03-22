//
//  SettingsViewModel.swift
//  MCourses
//
//  Created by Finn on 8/9/23.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderType] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    // TODO: Add logic to load users email into viewModel
    func signOut() throws {
       try AuthManager.shared.signOut()
    }
    // TODO: Add confirmation before deleting account, make them resign in to get reauthenticated. We also only deleted the auth, not the user profile in DB
    func deleteAccount() async throws {
        try await AuthManager.shared.deleteUser()
    }
}
