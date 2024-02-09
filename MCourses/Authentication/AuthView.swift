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
