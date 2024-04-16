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
                CourseItemView(courseItem: CourseItem(
                    name: "Data Structures and Algorithms",
                    department: "EECS",
                    number: 281,
                    credits: 4,
                    description: "Introduction to the algorithm analysis and O-notation; Fundamental data structures including lists, stacks, queues, priority queues, hash tables, binary trees, search trees, balanced, trees, and graphs; searching and sorting algorithms; recursive algorithms; basic graph algorithms; introduction to greedy algorithms and divide and conquer strategy. Several programming assignments.",
                    avgRating: 4.5,
                    avgDifficulty: 0.68))
                TabView {
                    SettingsView(showSignInView: .constant(false))
                        .tabItem {
                            NavigationLink {
                                SettingsView(showSignInView: .constant(false))
                            } label: {
                                Label("Settings", systemImage: "gear")
                            }
                        }
                    ProfileView(showSignInView: .constant(false))
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
