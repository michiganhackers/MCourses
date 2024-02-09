//
//  MCoursesApp.swift
//  MCourses
//
//  Created by Finn Moore on 10/26/23.
//
import SwiftUI
import Firebase

class AppDelegate : NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        //print("Configured Firebase!")
        return true
    }
}


@main
struct MCoursesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
    }
}
