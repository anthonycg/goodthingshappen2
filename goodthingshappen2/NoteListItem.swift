//
//  NoteListItem.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/23/24.
//

import SwiftUI

struct NoteListItem: View {
    var note: Note
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(Color.gray)
                .frame(width: .infinity, height: 250)
                .padding()
            Text("This is a test title")
                .foregroundStyle(Color.black)
                .font(.largeTitle)
                .frame(width: 320, height: 180, alignment: .bottomLeading)
                .lineLimit(1)
            Text("This is a test body summary and I want to show quite a bit of text here")
                .foregroundStyle(Color.black)
                .font(.title3)
                .frame(width: 320, height: 250, alignment: .bottomLeading)
                .lineLimit(1)
            
        }
    }
}

#Preview {
    NoteListItem(note: Note(postTitle: "Test", postBody: "bodytest"))
}
