//
//  AddNewNote.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/24/24.
//

import SwiftUI
import SwiftData
import FirebaseAuth

struct AddNewNote: View {
    @State var postTitle: String
    @State var postBody: String
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query var notes: [Note4]
    
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            VStack {
                TextField("Title your day...", text: $postTitle, axis: .vertical)
                    .font(.system(size: 40))
                    .lineLimit(3)
                    .padding([.leading, .trailing])
                
                Spacer()
                
                VStack {
                    VStack(alignment: .leading, spacing: 2) {
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
//                        .padding(.horizontal)

                        // Text section
                    VStack {
                        TextField("Write about the details of today...", text: $postBody, axis: .vertical)
                            .lineLimit(16)
                            .padding([.top, .bottom], 30)  // Add padding inside the TextField
                            .background(Color.green.opacity(0))  // Set background color
                            .cornerRadius(10)  // Apply corner radius for a smooth look
                            }
//                            .padding()

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
//                        .padding(.bottom)
                        
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
        guard !postTitle.isEmpty, !postBody.isEmpty else {
            print("Title and body cannot be empty")
            return
        }
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated")
            return
        }
        
        let note = Note4(postTitle: postTitle, postBody: postBody, ownerId: UUID(uuidString: userId)!)
        print(note)
        modelContext.insert(note)
        do {
            try modelContext.save()
            } catch {
                print("Failed to insert note")
        }
        dismiss()
    }

    }

#Preview {
    AddNewNote(postTitle: "", postBody: "")
        .modelContainer(for: [Note4.self, User3.self ])
}
