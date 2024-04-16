//
//  Review.swift
//  MCourses
//
//  Created by Finn Moore on 11/30/23.
//

import Foundation

struct Review: Identifiable, Decodable {
    var id: String?
    //let uid: String
    let course: String
    let semester: String
    let professor: String
    let review: String
    let rating: Double
    let workload: Double
    let worth: Double
    let enjoyment: Double
    let votes: Int
}
