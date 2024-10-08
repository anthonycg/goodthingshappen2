//
//  User3.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/29/24.
//

import Foundation
import SwiftData

@Model
class User3 {
    var id: UUID
    var firebaseId: String
    var name: String
    var email: String
    var gender: String
    var profileImg: String
    var createdAt: Date
    var updatedAt: Date
    
    init(id: UUID, firebaseId: String, name: String, email: String, gender: String = "", profileImg: String = "", createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.firebaseId = firebaseId
        self.name = name
        self.email = email
        self.gender = gender
        self.profileImg = profileImg
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}
