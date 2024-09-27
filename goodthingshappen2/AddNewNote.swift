//
//  AddNewNote.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/24/24.
//

import SwiftUI
import SwiftData

struct AddNewNote: View {
    @State var postTitle: String
    @State var postBody: String
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query var notes: [Note]
    
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            VStack {
                TextField("Title your day...", text: $postTitle, axis: .vertical)
                    .font(.system(size: 50))
                    .lineLimit(4)
                    .padding()
                
                Spacer()
                
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        // Top section with title and icon
                        HStack {
                            Image(systemName: "pencil.line")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            
                            Text("What good thing happened today?")
                                .font(.headline)
                                .foregroundColor(.black)
                            
                        }
                        .padding(.top, 10)
                        .padding(.horizontal)

                        // Text section
                    VStack {
                        TextField("Write about the details of today...", text: $postBody, axis: .vertical)
                            .lineLimit(8)
                            .padding([.top, .bottom], 60)  // Add padding inside the TextField
                            .background(Color.green.opacity(0))  // Set background color
                            .cornerRadius(10)  // Apply corner radius for a smooth look
                            }
                            .padding()

                        // Icon buttons at the bottom
                        HStack(spacing: 30) {
                            Button(action: {
                                // Action for the first button
                            }) {
                                Image(systemName: "camera")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                               saveNote()
                            }) {
                                Image(systemName: "checkmark.circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "x.circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(20)
                        .padding(.bottom)
                        
                    }
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.3), Color.green.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(30)
                    .padding()
                    .shadow(radius: 10)
                }
            }
                
                Spacer()
            }

        }
    func saveNote() {
        let note = Note(postTitle: postTitle, postBody: postBody)
        modelContext.insert(note)
        try? modelContext.save()
        dismiss()
    }
    }

#Preview {
    AddNewNote(postTitle: "test title", postBody: "test body")
}