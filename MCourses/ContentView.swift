//
//  ContentView.swift
//  MCourses
//
//  Created by Finn Moore on 10/26/23.
//

import SwiftUI


struct Course: Hashable, Codable {
    let name: String
    let department: String
    let number: Int
    let description: String
    let avgRating: Double
    let avgDifficulty: Double
}


struct ContentView: View {
    let courses: [Course] = [
        Course(name: "Data Structures and Algorithms",
              department: "EECS",
              number: 281,
             description: "Introduction to the algorithm analysis and O-notation; Fundamental data structures including lists, stacks, queues, priority queues, hash tables, binary trees, search trees, balanced, trees, and graphs; searching and sorting algorithms; recursive algorithms; basic graph algorithms; introduction to greedy algorithms and divide and conquer strategy. Several programming assignments.",
              avgRating: 4.5,
              avgDifficulty: 0.68),
        Course(name: "Linear Algebra",
              department: "MATH",
              number: 217,
             description: "Systems of linear equations; matrix algebra; vectors, vector spaces and subspaces; geometry of Rn; linear dependence, bases and dimension; linear transformations; Eigenvalues and Eigenvectors; diagonalization; inner products; spectral theorem, Gram-Schmidt process.",
              avgRating: 4.5,
              avgDifficulty: 0.85),
    ]
    var body: some View {
        VStack {
            ForEach(0..<courses.count) { course in
                Text(courses[course].name)
            }
        }
    }
}

#Preview {
    ContentView()
}
