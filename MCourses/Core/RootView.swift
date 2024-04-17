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
                    SettingsView(showSignInView: .constant(false))
                        .tabItem {
                            NavigationLink {
                                SettingsView(showSignInView: .constant(false))
                            } label: {
                                Label("Settings", systemImage: "gear")
                            }
                        }
                    SearchView()
                        .tabItem {
                            Label("", systemImage: "globe")
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
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
