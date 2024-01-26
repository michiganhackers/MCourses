//
//  CourseViewModel.swift
//  MCourses
//
//  Created by Finn Moore on 11/30/23.
//

import Foundation

class CourseViewModel: ObservableObject {
    @Published var course: Course
    init(course: Course) {
        self.course = course
    }
}
