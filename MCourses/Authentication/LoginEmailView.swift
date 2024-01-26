//
//  LoginEmailView.swift
//  MCourses
//
//  Created by Finn on 7/26/23.
//

import SwiftUI

struct LoginEmailView: View {
    @StateObject private var viewModel = LoginEmailViewModel()
    @Binding var showSignInView: Bool
     
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                    // if cant create new user
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign in")
            }

        }
        .padding()
        .navigationTitle("Sign in with Email")
    }
}

struct LoginEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginEmailView(showSignInView: .constant(false) )
        }
    }
}
