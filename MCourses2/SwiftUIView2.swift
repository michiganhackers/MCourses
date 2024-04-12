//
//  SwiftUIView2.swift
//  MCourses
//
//  Created by Camryn Ihrke on 2/8/24.
//

import SwiftUI

struct SwiftUIView2: View {
    @State private var searchText = ""

        var body: some View {
            NavigationStack {
                Text("Searching for \(searchText)")
                    
            }
            .searchable(text: $searchText)
        }
}

#Preview {
    SwiftUIView2()
}
