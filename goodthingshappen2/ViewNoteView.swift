//
//  EditNoteView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/29/24.
//
import SwiftData
import SwiftUI
import FirebaseAuth


struct ViewNoteView: View {
    @Binding var note: Note4
    var body: some View {
        ZStack {
            Color(.champagnePink).ignoresSafeArea()
            
            VStack {
                Text(note.postTitle)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.black).textInputAutocapitalization(.sentences)
                    .font(.custom("HelveticaNeue", size: 48)).frame(maxHeight: 200, alignment: .topLeading).padding()
                
                Spacer()
                
                Text(note.postBody)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.black).textInputAutocapitalization(.sentences)
                    .font(.custom("HelveticaNeue", size: 20)).frame(maxHeight: .infinity, alignment: .topLeading).padding(.horizontal)
                
            }
            
        }
    }
}

#Preview {
    // Create an example note
    let example = Note4(postTitle: "Hello", postBody: "Example details go here and this is a body so we can see what a bunch of text looks like in the body of a text editor or text field that has a vertical axis that is expandable.", ownerId: UUID())
    
    // Configure the model container
    EditNoteView(note: example)
        .modelContainer(for: [Note4.self], inMemory: true)
}


