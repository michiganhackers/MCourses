//
//  CourseItemViewModel.swift
//  MCourses
//
//  Created by Finn Moore on 11/2/23.
//

import Foundation

class CourseItemViewModel: ObservableObject {
    @Published var courseItem: CourseItem
    init(courseItem: CourseItem) {
        self.courseItem = courseItem
    }
}
