//
//  NoteListItem.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/23/24.
//

import SwiftUI

struct NoteListItem: View {
    var note: Note3
    @State var isEditingNote: Bool = false
    
    var body: some View {
        Button(action: {
            isEditingNote = true
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(
                        LinearGradient(colors: [.lightTeaGreen, .teaGreen], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(maxWidth: .infinity, minHeight: 255, maxHeight: 255)  // Use maxWidth
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(note.postTitle.isEmpty ? "Untitled" : note.postTitle)
                        .frame(width: 330, height: 200, alignment: .bottomLeading)
                        .foregroundStyle(Color.black)
                        .font(.largeTitle)
                        .lineLimit(2)
                    
                    Text(note.postBody.isEmpty ? "No details yet." : note.postBody) 
                        .frame(width: 330, height: 30, alignment: .bottomLeading)
                        .foregroundStyle(Color.black)
                        .font(.title3)
                        .lineLimit(1)
                }
            }
        }
        .sheet(isPresented: $isEditingNote) {
            EditNoteView(note: note)
        }
    }
}

#Preview {
    NoteListItem(note: Note3(postTitle: "Sample Title that has a bunch of text and this is eve", postBody: "Sample Body witha a bit more text faadsfadsf"))
}
