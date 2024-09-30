//
//  Note.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/21/24.
//

import Foundation
import SwiftData

@Model
final class Note {
    var postTitle: String
    var postBody: String
    var imageURL: String
    var publicPost: Bool
    var likes: Set<String>
    var collection: Set<String>
    var createdAt: Date
    var updatedAt: Date
    
    init(postTitle: String, postBody: String, imageURL: String = "", publicPost: Bool = false, likes: Set<String> = Set(), collection: Set<String> = Set(), createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.postTitle = postTitle
        self.postBody = postBody
        self.imageURL = imageURL
        self.publicPost = publicPost
        self.likes = likes
        self.collection = collection
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
