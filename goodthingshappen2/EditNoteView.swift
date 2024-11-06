//
//  EditNoteView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/29/24.
//
import SwiftData
import SwiftUI
import FirebaseAuth

struct EditNoteView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var note: Note6
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.champagnePink).ignoresSafeArea()
                
                VStack {
                    ZStack(alignment: .topLeading) {
                        if note.postTitle.isEmpty {
                            Text("Title your day...")
                                .foregroundColor(.black.opacity(0.3))
                                .font(.custom("HelveticaNeue", size: 48))
                                .padding(.horizontal)
                                .padding(.top, 8)
                        }
                        
                        TextField("", text: $note.postTitle, axis: .vertical)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.black)
                            .textInputAutocapitalization(.sentences)
                            .font(.custom("HelveticaNeue", size: 48))
                            .frame(maxHeight: 200, alignment: .topLeading)
                            .padding()
                    }
                    
                    if let imageData = note.imageURL,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, minHeight: 225, maxHeight: 225)
                            .clipped()
                            .cornerRadius(30)
                            .padding(.bottom)
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .topLeading) {
                        if note.postBody.isEmpty {
                            Text("What good thing happened today?")
                                .foregroundColor(.black.opacity(0.3))
                                .font(.custom("HelveticaNeue", size: 20))
                                .padding(.horizontal)
                                .padding(.top, 8)
                        }
                        
                        TextField("", text: $note.postBody, axis: .vertical)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.black)
                            .textInputAutocapitalization(.sentences)
                            .font(.custom("HelveticaNeue", size: 20))
                            .frame(maxHeight: .infinity, alignment: .topLeading)
                            .padding(.horizontal)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}


#Preview {
    // Create an example note
    let example = Note6(postTitle: "Hello", postBody: "Example details go here and this is a body so we can see what a bunch of text looks like in the body of a text editor or text field that has a vertical axis that is expandable.", ownerId: UUID().uuidString)
    
    // Configure the model container
    EditNoteView(note: example)
        .modelContainer(for: [Note6.self], inMemory: true)
}


