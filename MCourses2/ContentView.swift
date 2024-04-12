//
//  ContentView.swift
//  MCourses2
//
//  Created by Ishani Das on 3/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            VStack {
                /*
                 Text("EECS Courses").font(.title)
                 Menu {
                 Button(action: {}, label: {Text("EECS 183")})
                 Button(action: {}, label: {Text("EECS 203")})
                 Button(action: {}, label: {Text("EECS 280")})
                 Button(action: {}, label: {Text("EECS 281")})
                 } label: {
                 Label(title: {Text("Browse Below")}, icon: {Image(systemName: "magnifyingglass")})
                 }
                 */
                /*
                 Image(systemName: "globe")
                 .imageScale(.large)
                 .foregroundStyle(.tint)
                 Text("Hello, world!")
                 */
                // Spacer()
                Text("Filter Your Search").font(.title).bold().padding(.top, 30)
                Spacer()
                Text("Sort by").multilineTextAlignment(.leading).font(.headline)
                Menu {
                    
                    Button(action: {}, label: {Text("Rating 📊")}) // chart.bar.xaxis
                    Button(action: {}, label: {Text("Workload 📝")})
                    Button(action: {}, label: {Text("Name 🗣️")})
                } label: {
                    Label(title: {Text("Select Below")} , icon: {Image(systemName: "blahblahblah")}) // magnifyingglass
                }
                Spacer()
                Text("Filter by").multilineTextAlignment(.leading).font(.headline)
                Menu {
                    Button(action: {}, label: {Text("Credits 🗒️")})
                    Button(action: {}, label: {Text("Department 🏫")})
                } label: {
                    Label(title: {Text("Select Below")} , icon: {Image(systemName: "blahblahblah")}) // magnifyingglass
                }
                Spacer()
                
                // NavigationView(){
                NavigationLink() {
                    // print("Search2 clicked")
                    //ClassesListView()
                    SwiftUIView()
                } label: {
                    Text("Search")
                        .padding(20).foregroundColor(.white)
                }.frame(width: 300).background(Color(red: 0, green: 39/255, blue: 76/255)).contentShape(RoundedRectangle(cornerRadius: 10))
                    .clipShape(RoundedRectangle(cornerRadius: 10)).bold()
                // }
                
                
                // NavigationLink(destination: ClassesListView()){
                /*
                Button() {
                    print("Search1 clicked")
                } label: {
                    Text("Search")
                        .padding(20).foregroundColor(.white)
                }.frame(width: 300).background(Color(red: 0, green: 39/255, blue: 76/255)).contentShape(RoundedRectangle(cornerRadius: 10))
                    .clipShape(RoundedRectangle(cornerRadius: 10)).bold()
                // }
                 */
                
            }
            .padding()
        }
    }
}



#Preview {
    ContentView()
}
