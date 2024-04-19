//
//  CourseViewModel.swift
//  MCourses
//
//  Created by Finn Moore on 11/30/23.
//

import Foundation

class CourseViewModel: ObservableObject {
    @Published var course: Course
    @Published var reviews: [Review] = []
    let courseService = CourseService()
    
    init(course: Course) {
        self.course = course
        Task { @MainActor in
            try await fetchReviews()
        }
    }
    
    func fetchReviews() async throws {
        Task { @MainActor in
            let fetchedReviews = try await courseService.fetchReviews(forCourse: self.course)
            reviews = fetchedReviews
            var sum_enjoyment = 0.0
            var sum_workload = 0.0
            var sum_worth = 0.0
            var sum_rating = 0.0
            for review in fetchedReviews {
                sum_enjoyment += review.enjoyment
                sum_workload += review.workload
                sum_worth += review.worth
                sum_rating += review.rating
            }
            self.course.avgEnjoyment = fetchedReviews.count != 0 ? sum_enjoyment / Double(fetchedReviews.count) : -1.0
            self.course.avgWorkload = fetchedReviews.count != 0 ? sum_workload / Double(fetchedReviews.count) : -1.0
            self.course.avgWorth = fetchedReviews.count != 0 ? sum_worth / Double(fetchedReviews.count) : -1.0
            self.course.avgRating = fetchedReviews.count != 0 ? sum_rating / Double(fetchedReviews.count) : -1.0
            print("DEBUG!!!")
            print(reviews)
        }
    }
    
    
}

