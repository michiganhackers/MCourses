//
//  GoogleSignInHelper.swift
//  MCourses
//
//  Created by Finn on 7/29/23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth
import FirebaseCore

struct GoogleSignInModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}

final class GoogleSignInHelper{
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            // make real error
            throw URLError(.badURL)
        }
        guard let clientID = FirebaseApp.app()?.options.clientID else { throw URLError(.badURL)}
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        print(GIDSignIn.sharedInstance)
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            // make error
            throw URLError(.badURL)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
}
