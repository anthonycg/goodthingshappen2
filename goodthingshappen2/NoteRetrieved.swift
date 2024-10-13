//
//  NoteRetrieved.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/13/24.
//

import Foundation

struct NoteRetrieved: Codable, Identifiable {
    let id: String
    let posttitle: String
    let postbody: String
    let imageurl: String
    let publicpost: Bool
    let ownerid: String
    let likes: Likes
    let createdat: String
    let updatedat: String
    let username: String
}

struct Likes: Codable {
    let data: [UInt8]
}
