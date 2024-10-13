//
//  FeedNoteView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/10/24.
//

import SwiftData
import SwiftUI
import FirebaseAuth


struct FeedNoteView: View {
    var note: NoteRetrieved
    var body: some View {
        ZStack {
            Color(.champagnePink).ignoresSafeArea()
            ScrollView {
                VStack {
                    Text(note.posttitle)
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.black).textInputAutocapitalization(.sentences)
                        .font(.custom("HelveticaNeue", size: 48)).frame(maxHeight: 200, alignment: .topLeading)
                        .padding()
                        .disabled(true)
                    
//                    if let imageData = note.imageUrl,
//                       let uiImage = UIImage(data: imageData) {
//                        Image(uiImage: uiImage)
//                            .resizable()
//                            .scaledToFill()  // Use scaledToFill to cover the area
//                            .frame(maxWidth: .infinity, minHeight: 225, maxHeight: 225) // Match the rectangle size
//                            .clipped()
//                            .cornerRadius(30)
//                            .padding(.bottom)
//                    }
                    Spacer()
                    
                    Text(note.postbody)
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.black).textInputAutocapitalization(.sentences)
                        .font(.custom("HelveticaNeue", size: 20)).frame(maxHeight: .infinity, alignment: .topLeading).padding(.horizontal)
                        .disabled(true)
                    
                }
            }
            
        }
    }
}

#Preview {
    // Create an example note
    let example = NoteRetrieved(id: "4242", posttitle: "Sample Title that has a bunch of text and this is eve", postbody: "Sample Body witha a bit more text faadsfadsf", imageurl: "", publicpost: false, ownerid: UUID().uuidString, likes: Likes(data: [123, 125]), createdat: "100", updatedat: "20", username: "Hello")
    
    // Configure the model container
    FeedNoteView(note: example)
        .modelContainer(for: [Note6.self], inMemory: true)
}


