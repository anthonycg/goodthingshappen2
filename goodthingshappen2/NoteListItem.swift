//
//  NoteListItem.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/23/24.
//

import SwiftUI
import FirebaseAuth

struct NoteListItem: View {
    var note: Note6
    @State var isEditingNote: Bool = false
    @State var uiImage: Image?

    var body: some View {
        Button(action: {
            isEditingNote = true
        }) {
            ZStack {
                // Check if imageData exists and is valid, then display the image
                if let imageData = note.imageURL,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()  // Use scaledToFill to cover the area
                        .frame(maxWidth: .infinity, minHeight: 225, maxHeight: 225) // Match the rectangle size
                        .clipped()
                        .cornerRadius(30)
                        .padding(.bottom)
                }

                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(
                        LinearGradient(colors: [.lightTeaGreen.opacity((uiImage != nil) ? 0.0 : 0.8), .teaGreen.opacity((uiImage != nil) ? 0.0 : 0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(maxWidth: .infinity, minHeight: 225, maxHeight: 225) // Maintain the frame
                    .padding(.bottom)

                VStack(alignment: .leading) {
                    Text(note.postTitle.isEmpty ? "Untitled" : note.postTitle)
                        .frame(width: 330, height: 150, alignment: .bottomLeading)
                        .foregroundStyle(Color.black)
                        .font(.largeTitle)
                        .lineLimit(2)

                    Text(note.postBody.isEmpty ? "No details yet." : note.postBody)
                        .frame(width: 330, height: 30, alignment: .bottomLeading)
                        .foregroundStyle(Color.black)
                        .font(.title3)
                        .lineLimit(1)
                }
                .padding() // Add some padding to the text for better readability
            }
        }
        .sheet(isPresented: $isEditingNote) {
            EditNoteView(note: note)
        }
    }
}

#Preview {
    NoteListItem(note: Note6(postTitle: "Sample Title that has a bunch of text and this is eve", postBody: "Sample Body with a bit more text faadsfadsf", ownerId: UUID().uuidString))
}
