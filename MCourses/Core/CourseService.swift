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
        return courses
    }
}

// MARK: - Review Logic
extension CourseService {
    func reviewCourse(course: Course, review: Review) async throws {
        guard let uid = getCurrentUserID() else { return }
        guard let reviewID = review.id else { return }
            
            let data: [String: Any] = [
                "uid": uid,
                "timestamp": review.timestamp,
                "review": review.review,
                "semester": review.semester,
                "professor": review.professor,
                "rating": review.rating,
                "workload": review.workload,
                "worth": review.worth,
                "enjoyment": review.enjoyment,
                "votes": 0
            ]
            
            // NOTE: This has all quotes in one collection... everything is global... no following!
        try await Firestore.firestore().collection("courses").document("\(course.department) \(course.number)").collection("reviews").document(reviewID).setData(data)
    }
    
    func fetchReviews(forCourse course: Course) async throws -> [Review] {
        let snapshot = try await Firestore.firestore().collection("courses").document("\(course.department) \(course.number)").collection("reviews")
            .getDocuments()
        var reviews: [Review] = []
        for document in snapshot.documents {
            let data = document.data()
            guard let timestamp = data["timestamp"] as? Timestamp else { continue }
            guard let semester = data["semester"] as? String else { continue }
            guard let professor = data["professor"] as? String else { continue }
            guard let review = data["review"] as? String else { continue }
            guard let rating = data["rating"] as? Double else { continue }
            guard let workload = data["workload"] as? Double else { continue }
            guard let worth = data["worth"] as? Double else { continue }
            guard let enjoyment = data["enjoyment"] as? Double else { continue }
            guard let votes = data["votes"] as? Int else { continue }
            reviews.append(Review(id: document.documentID, timestamp: timestamp, semester: semester, professor: professor, review: review, rating: rating, workload: workload, worth: worth, enjoyment: enjoyment, votes: votes))

        }
        return reviews
    }
    
    
    func deleteReview(course: Course, review: Review) {
        guard let reviewID = review.id else { print("ERROR ReviewService deleteReview: no reviewID");return }
        Firestore.firestore().collection("courses").document("\(course.department) \(course.number)").collection("reviews").document(reviewID).delete()
    }
}

// MARK: - Helpers
extension CourseService {
    private func getCurrentUserID() -> String? {
        Auth.auth().currentUser?.uid
    }
}
