//
//  Course.swift
//  MCourses
//
//  Created by Finn Moore on 11/30/23.
//

import Foundation


struct Course: Identifiable, Decodable {
    var id: String?
    let name: String
    let department: String
    let number: Int
    let credits: Int
    let description: String
    var avgRating: Double
    var avgWorkload: Double
    var avgWorth: Double
    var avgEnjoyment: Double
    var reviews: [Review]
}
