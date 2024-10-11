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
    @Bindable var note: Note6
    var body: some View {
        ZStack {
            Color(.champagnePink).ignoresSafeArea()
            ScrollView {
                VStack {
                    Text(note.postTitle)
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.black).textInputAutocapitalization(.sentences)
                        .font(.custom("HelveticaNeue", size: 48)).frame(maxHeight: 200, alignment: .topLeading)
                        .padding()
                        .disabled(true)
                    
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
                    Spacer()
                    
                    Text(note.postBody)
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
    let example = Note6(postTitle: "Hello", postBody: "Example details go here and this is a body so we can see what a bunch of text looks like in the body of a text editor or text field that has a vertical axis that is expandable.", ownerId: UUID().uuidString)
    
    // Configure the model container
    FeedNoteView(note: example)
        .modelContainer(for: [Note6.self], inMemory: true)
}


