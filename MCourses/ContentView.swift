//
//  ContentView.swift
//  MCourses
//
//  Created by Finn Moore on 10/26/23.
//

import SwiftUI
import UIKit
import WebKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "graduationcap")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                
                Text("MCourses")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(
                    destination: WebView(url: URL(string: "https://weblogin.umich.edu")!),
                    label: {
                        Text("Login")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                )
            }
        }
    }
}

struct WebView: View {
    let url: URL

    var body: some View {
        SwiftUIWebView(url: url)
            .navigationBarTitle("", displayMode: .inline)
    }
}

struct SwiftUIWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> UIView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let uiWebView = uiView as? WKWebView {
            let request = URLRequest(url: url)
            uiWebView.load(request)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
