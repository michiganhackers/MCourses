//
//  CourseService.swift
//  MCourses
//
//  Created by Finn Moore on 4/13/24.
//

import Firebase

struct CourseService {
    func fetchCourses() async throws -> [Course] {
        let snapshot = try await Firestore.firestore().collection("courses")
            .getDocuments()
        var courses : [Course] = []
        
        for document in snapshot.documents {
            guard let name = document.data()["name"] as? String else { continue }
            guard let department = document.data()["department"] as? String else { continue }
            guard let number = document.data()["number"] as? Int else { continue }
            guard let credits = document.data()["credits"] as? Int else { continue }
            guard let description = document.data()["description"] as? String else { continue }
            guard let avgRating = document.data()["avgRating"] as? Double else { continue }
            guard let avgWorkload = document.data()["avgWorkload"] as? Double else { continue }
            guard let avgWorth = document.data()["avgWorth"] as? Double else { continue }
            guard let avgEnjoyment = document.data()["avgEnjoyment"] as? Double else { continue }
            courses.append(Course(id: UUID().uuidString, name: name, department: department, number: number, credits: credits, description: description, avgRating: avgRating, avgWorkload: avgWorkload, avgWorth: avgWorth, avgEnjoyment: avgEnjoyment, reviews: []))

        }

        print(courses)
        return courses
    }
}
