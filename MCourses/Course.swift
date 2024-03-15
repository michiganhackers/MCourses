//
//  Class.swift
//  MCourses
//
//  Created by Camryn Ihrke on 11/30/23.
//

import Foundation

struct Course: Hashable, Codable {
    //var id: Int
    var name: String
    //var description: String
    //var creditCount: Int
    init(name: String) {
        self.name = name
    }
}

