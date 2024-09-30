//
//  Note3.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/29/24.
//
import Foundation
import SwiftData

@Model
class Note3 {
    var postTitle: String
    var postBody: String
    var imageURL: String
    var publicPost: Bool
    var likes: Data // Changed to Data
    var collection: Data // Changed to Data
    var createdAt: Date
    var updatedAt: Date

    init(postTitle: String, postBody: String, imageURL: String = "", publicPost: Bool = false, likes: [likeType] = [], collection: [collectionType] = [], createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.postTitle = postTitle
        self.postBody = postBody
        self.imageURL = imageURL
        self.publicPost = publicPost
        self.likes = try! JSONEncoder().encode(likes) // Encode array to Data
        self.collection = try! JSONEncoder().encode(collection) // Encode array to Data
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    struct likeType: Codable {
        var userId: String
    }

    struct collectionType: Codable {
        var name: String
    }

    // Helper to decode `likes` and `collection` arrays when needed
    func getLikes() -> [likeType] {
        return try! JSONDecoder().decode([likeType].self, from: likes)
    }

    func getCollection() -> [collectionType] {
        return try! JSONDecoder().decode([collectionType].self, from: collection)
    }
}
