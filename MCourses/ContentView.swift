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
            VStack{
                LoginScreenWrapper()
            }
        }
    }
}
class ViewController: UIViewController {
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    @IBAction func LoginClicked(_ sender: UIButton)
        {
            print ("Login Button Clicked!")
            UIApplication.shared.open(URL(string:"https://weblogin.umich.edu")! as URL, options: [:], completionHandler: nil)
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
