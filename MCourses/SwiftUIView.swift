//
//  SwiftUIView.swift
//  MCourses
//
//  Created by Camryn Ihrke on 11/16/23.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var search: String = ""
    var body: some View {
        VStack() {
            HStack() {
                ZStack() {
                    HStack() {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $search)
                            .font(Font.custom("SF Pro Text", size: 15).weight(.semibold))
                            .lineSpacing(18)
                            .foregroundColor(Color(red: 0.60, green: 0.61, blue: 0.59))
                        
//                        Text("Search for courses")
//                            .font(Font.custom("SF Pro Text", size: 13).weight(.semibold))
//                            .lineSpacing(18)
//                            .foregroundColor(Color(red: 0.60, green: 0.61, blue: 0.59))
                        Spacer()
                    }
                    .padding(.leading)
                    .frame(width:268, height: 50)
                    .zIndex(2)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 268.0, height: 50)
                        .background(.white)
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color(red: 0, green: 0.15, blue: 0.30), lineWidth: 1)
                        )
                    
                        .zIndex(1)
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0, green: 0.15, blue: 0.30))
                        .cornerRadius(8)
                    Image(systemName: "slider.horizontal.3")
                        .renderingMode(.original)
                        .foregroundStyle(.white)
                        .imageScale(.large)
                }
                .frame(width: 68, height: 18)
            }
            List {
                ScrollView {
                    ClassView(course: Course(name: "EECS 338: Introduction to Security"))
                    ClassView(course: Course(name: "EECS 338: Introduction to Security"))
                    ClassView(course: Course(name: "EECS 338: Introduction to Security"))
                    ClassView(course: Course(name: "EECS 338: Introduction to Security"))
                    ClassView(course: Course(name: "EECS 338: Introduction to Security"))
                    ClassView(course: Course(name: "EECS 338: Introduction to Security"))


                }
                
            }
            .scrollContentBackground(.hidden)
            .listStyle(GroupedListStyle()) // or PlainListStyle()
            
            
            Spacer()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
