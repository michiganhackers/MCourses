//
//  SearchViewModel.swift
//  MCourses
//
//  Created by Finn Moore on 4/15/2024.
//

import Foundation

class SearchViewModel: ObservableObject, FetchCourses {
    
    @Published var courses: [Course] = []
    
    let courseService = CourseService()
    
    init() {
        fetchCourses()
    }
    
    func fetchCourses() {
        Task { @MainActor in
            let fetchedCourses = try await courseService.fetchCourses()
            self.courses = fetchedCourses
            print(fetchedCourses)
            print("--------")
            print(self.courses)
        }
    }
}
