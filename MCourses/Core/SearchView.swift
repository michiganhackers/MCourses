//
//  SwiftUIView.swift
//  MCourses
//
//  Created by Camryn Ihrke on 11/16/23.
//

import SwiftUI

struct SearchView: View {
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
                
                NavigationLink(destination: FilterView()) {
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
                }

                .frame(width: 68, height: 18)
            }
            List {
                ScrollView {
                    VStack {
                        ClassView(course: SearchCourse(name: "EECS 183: Elementary Programming Concepts"))
                        ClassView(course: SearchCourse(name: "EECS 203: Discrete Mathemattics"))
                        ClassView(course: SearchCourse(name: "EECS 280: Programming and Intro Data Structures"))
                        ClassView(course: SearchCourse(name: "EECS 281: Data Structures and Algorithms"))
                        ClassView(course: SearchCourse(name: "EECS 370: Intro to Computer Organization"))
                        ClassView(course: SearchCourse(name: "EECS 376: Foundations of Computer Science"))
                        ClassView(course: SearchCourse(name: "EECS 338: Introduction to Security"))
                    }
                }
                
            }
            .scrollContentBackground(.hidden)
            .listStyle(GroupedListStyle()) // or PlainListStyle()
            
            Spacer()
        }
    }
}

let sampleCourse2 = Course(
    name: "Data Structures and Algorithms",
    department: "EECS",
    number: 281,
    credits: 4,
    description: "Introduction to the algorithm analysis and O-notation; Fundamental data structures including lists, stacks, queues, priority queues, hash tables, binary trees, search trees, balanced, trees, and graphs; searching and sorting algorithms; recursive algorithms; basic graph algorithms; introduction to greedy algorithms and divide and conquer strategy. Several programming assignments.",
    avgRating: 4.5,
    avgWorkload: 6.8,
    avgWorth: 7.7,
   avgEnjoyment: 3.4,
   reviews: [sampleReview1, sampleReview2])

struct ClassView: View {
    var course: SearchCourse
    
    var body: some View {
        NavigationLink(destination: CourseView(course: sampleCourse2)) {
            VStack {
              // Title
                Text(course.name)
                .font(Font.custom("SF Pro Text", size: 17).weight(.semibold))
                .lineSpacing(22)
                .foregroundColor(.black)
              Spacer()
            }
            .padding(EdgeInsets(top: 14, leading: 11, bottom: 24, trailing: 0))
            .frame(width: 375, height: 142)
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        }
    }
}


#Preview {
    SearchView()
}
