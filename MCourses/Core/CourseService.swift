//
//  CourseService.swift
//  MCourses
//
//  Created by Finn Moore on 4/13/24.
//

import Firebase

struct CourseService {
    func fetchCourses() async throws -> [Course] {
        let snapshot = try await Firestore.firestore().collection("classes")
            .getDocuments()
        for document in snapshot.documents {
            print("\(document.documentID) => \(document.data())")
        }

        let documents = snapshot.documents
        
        let courses = documents.compactMap {
            try? $0.data(as: Course.self)
        }
        return courses
    }
}
