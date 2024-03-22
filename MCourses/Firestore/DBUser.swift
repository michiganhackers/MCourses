//
//  DBUser.swift
//  MCourses
//
//  Created by Finn on 8/13/23.
//

import Foundation

struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let profileImageURLString: String?
    let profileImagePath: String?

    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.profileImageURLString = nil
        self.profileImagePath = nil
    }
    
    init(
        userId: String,
        email: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        profileImageURLString: String? = nil,
        profileImagePath: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.profileImageURLString = profileImageURLString
        self.profileImagePath = profileImagePath
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case profileImageURLString = "profile_image_url_string"
        case profileImagePath = "profile_image_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.profileImageURLString = try container.decodeIfPresent(String.self, forKey: .profileImageURLString)
        self.profileImagePath = try container.decodeIfPresent(String.self, forKey: .profileImagePath)
    }
        
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.profileImageURLString, forKey: .profileImageURLString)
        try container.encodeIfPresent(self.profileImagePath, forKey: .profileImagePath)
    }
}
