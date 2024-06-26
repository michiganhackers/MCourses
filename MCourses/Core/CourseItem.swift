//
//  CourseItem.swift
//  MCourses
//
//  Created by Finn Moore on 11/2/23.
//

import Foundation

struct CourseItem: Identifiable, Decodable {
    var id: String?
    let name: String
    let department: String
    let number: Int
    let credits: Int
    let description: String
    let avgRating: Double
    let avgWorkload: Double
    let avgWorth: Double
    let avgEnjoyment: Double
}
