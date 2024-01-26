//
//  ContentView.swift
//  MCourses
//
//  Created by Finn Moore on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "graduationcap")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("MCourses")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
