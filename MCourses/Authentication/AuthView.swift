//
//  LoginView.swift
//  MCourses
//
//  Created by Finn on 7/26/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Binding var showSignInView: Bool
    
    
    
    var body: some View {
        VStack {
            NavigationLink {
                LoginEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign in with Email")
            }
            
            GoogleSignInButton {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }.padding()
            Button("Login with facebook") {
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthView(showSignInView: .constant(false))
        }
    }
}
