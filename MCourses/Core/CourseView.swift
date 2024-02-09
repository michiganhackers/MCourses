//
//  SwiftUIView.swift
//  MCourses
//
//  Created by Finn Moore on 11/16/23.
//

import SwiftUI

struct CourseView: View {
    @ObservedObject var courseViewModel: CourseViewModel
    
    // Colors
    let maize = Color(red: 1, green: 0.796, blue: 0.02)
    let blue = Color(red: 0, green: 0.153, blue: 0.298)
    
    init(course: Course) {
        self.courseViewModel = CourseViewModel(course: course)
    }
    
    var header: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(height: 200.0)
                    .foregroundColor(blue)
                Text(courseViewModel.course.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            .ignoresSafeArea()
            HStack(spacing: 20, content: {
                Text("\(courseViewModel.course.department) \(courseViewModel.course.number)")
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding()
                    .background(maize, in: RoundedRectangle(cornerRadius: 10))

                Text("\(courseViewModel.course.credits) Credits")
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding()
                    .background(maize, in: RoundedRectangle(cornerRadius: 10))
            })
            .offset(y:-50)
        }
    }
    
    var body: some View {
        VStack() {
            header
        }
    }
}

#Preview {
    CourseView(course: Course(name: "Data Structures and Algorithms",
   department: "EECS",
   number: 281,
   credits: 4,
   description: "Introduction to the algorithm analysis and O-notation; Fundamental data structures including lists, stacks, queues, priority queues, hash tables, binary trees, search trees, balanced, trees, and graphs; searching and sorting algorithms; recursive algorithms; basic graph algorithms; introduction to greedy algorithms and divide and conquer strategy. Several programming assignments.",
   avgRating: 4.5,
   avgWorkload: 6.8,
   avgWorth: 7.7,
  avgEnjoyment: 3.4,
  reviews: []))
}
