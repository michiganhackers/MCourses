//
//  ProfileView.swift
//  MCourses
//
//  Created by Finn on 8/9/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var url: URL?  = nil
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserID: \(user.userId)")
                if let date = user.dateCreated {
                    Text("Account created on \(date.description)")
                }
                
//                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
//                    Text("Select a photo")
//                }
                
                if let urlString = viewModel.user?.profileImageURLString, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 150)
                    }
                    if viewModel.user?.profileImagePath != nil {
                        Button("Delete Image") {
                            viewModel.deleteProfileImage()
                        }
                    }
                }
            } else {
                Text("No user")
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .onChange(of: selectedItem, perform: { newValue in
            if let newValue {
                try? viewModel.saveProfileImage(item: newValue)
            }
        })
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(showSignInView: .constant(false))
        }
    }
}
