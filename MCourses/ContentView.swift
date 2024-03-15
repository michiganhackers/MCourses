//
//  ContentView.swift
//  MCourses
//
//  Created by Finn Moore on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var launchScreenAppeared = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0/255, green: 39/255, blue: 76/255)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)
                        .padding(.bottom, 2)

                    Text("COURSES")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold))
                        .padding(.top, 2)

                    NavigationLink(destination: NewScreen(), isActive: $launchScreenAppeared) {
                        EmptyView()
                    }
                    .hidden() // Hide the navigation link, we're using it programmatically

                }
                .padding()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            launchScreenAppeared = true
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct NewScreen: View {
    @State private var isWebViewPresented = false
    
    var body: some View {
        VStack {
            Text("Welcome to")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(Color(red: 19/255, green: 21/255, blue: 22/255)) // HEX: 131516
                .padding(.bottom, 0) // brings words closer together
                .padding(.leading, -135) // shift left the more negative
            Text("M-COURSES")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color(red: 255/255, green: 203/255, blue: 5/255)) // HEX: FFCB05
                .padding(.leading, -60) // shift left
            Text("Continue with your university email.")
                .font(.system(size:12))
                .padding(.top, 1)
                .padding(.leading, -100)
            
            Button(action: {
                // Open the web URL when the button is clicked
                if let url = URL(string: "https://weblogin.umich.edu/") {
                    UIApplication.shared.open(url)
                }
                
            }) 
            {
                Text("Login")
                    .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .cornerRadius(10)
                            .frame(width: 300, height: 50) // Adjust the height to be longer
                // hi
            }
            .background(Color(red: 0/255, green: 39/255, blue: 76/255)) // HEX: 00274C
            .padding(.top, 20)
        }
        .frame(width: 300, height: 30)
    }
}
#Preview {
    ContentView()
}
