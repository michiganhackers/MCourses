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
    let avgRating: Double
    let avgWorkload: Double
    let avgWorth: Double
    let avgEnjoyment: Double
    let reviews: [Review]
}
