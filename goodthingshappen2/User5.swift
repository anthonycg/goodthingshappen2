//
//  User5.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/13/24.
//

import Foundation
import SwiftData

@Model
class User5 {
    var id: String
    var name: String
    var email: String
    var gender: String?
    var age: Int?
    var profileImg: String?
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, name: String, email: String, createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}
