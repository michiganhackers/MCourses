//
//  RootView.swift
//  MCourses
//
//  Created by Finn on 7/26/23.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                TabView {
                    SearchView()
                        .tabItem {
                            Label("", systemImage: "globe")
                        }
                    SettingsView(showSignInView: $showSignInView)
                        .tabItem {
                            NavigationLink {
                                SettingsView(showSignInView: $showSignInView)
                            } label: {
                                Label("Settings", systemImage: "gear")
                            }
                        }
                }
            }
        }
        .onAppear {
            let authUser = try? AuthManager.shared.getUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthView(showSignInView: $showSignInView)
            }.tint(.white)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
