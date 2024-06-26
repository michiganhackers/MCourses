//
//  CourseListView.swift
//  MCourses
//
//  Created by Finn Moore on 11/2/23.
//

import SwiftUI

protocol FetchCourses {
    func fetchCourses()
}

struct CourseItemView: View {
    @ObservedObject var courseItemViewModel: CourseItemViewModel
    
    init(courseItem: CourseItem) {
        self.courseItemViewModel = CourseItemViewModel(courseItem: courseItem)
    }
    
    init(course: Course) {
        self.courseItemViewModel = CourseItemViewModel(courseItem: CourseItem(name: course.name, department: course.department, number: course.number, credits: course.credits, description: course.description, avgRating: course.avgRating, avgWorkload: course.avgWorkload, avgWorth: course.avgWorth, avgEnjoyment: course.avgEnjoyment))
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(courseItemViewModel.courseItem.name)
                Text("\(courseItemViewModel.courseItem.department)  \(courseItemViewModel.courseItem.number)")
                Text(courseItemViewModel.courseItem.description)
                    .truncationMode(.tail)
            }
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
    }
}

#Preview {
    CourseItemView(courseItem: CourseItem(
        name: "Data Structures and Algorithms",
        department: "EECS",
        number: 281,
        credits: 4,
        description: "Introduction to the algorithm analysis and O-notation; Fundamental data structures including lists, stacks, queues, priority queues, hash tables, binary trees, search trees, balanced, trees, and graphs; searching and sorting algorithms; recursive algorithms; basic graph algorithms; introduction to greedy algorithms and divide and conquer strategy. Several programming assignments.",
        avgRating: 4.5,
        avgWorkload: 0.68,
        avgWorth: 10,
        avgEnjoyment: 10))
}
