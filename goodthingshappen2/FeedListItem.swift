//
//  NoteListItem.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/29/24.
//

import SwiftUI
import FirebaseAuth

struct FeedListItem: View {
    var note: Note6
    @State var isViewingNote: Bool = false
    @State var userHasLikedPost: Bool = false
    @State var likes: [String] = []  
    
    var body: some View {
        let currentUserId = Auth.auth().currentUser?.uid ?? ""
        
        Button(action: {
            isViewingNote = true
        }) {
            ZStack {
                if let imageData = note.imageURL,
                      let uiImage = UIImage(data: imageData) {
                       Image(uiImage: uiImage)
                           .resizable()
                           .ignoresSafeArea()
                   }
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(
                        LinearGradient(colors: [.lightTeaGreen.opacity(0.5), .teaGreen.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(maxWidth: .infinity, minHeight: 255, maxHeight: 255)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(note.postTitle.isEmpty ? "Untitled" : note.postTitle)
                        .frame(width: 330, height: 150, alignment: .bottomLeading)
                        .foregroundStyle(Color.black)
                        .font(.largeTitle)
                        .lineLimit(1)
                    
                    Text(note.postBody.isEmpty ? "No details yet." : note.postBody)
                        .frame(width: 330, height: 30, alignment: .bottomLeading)
                        .foregroundStyle(Color.black)
                        .font(.title3)
                        .lineLimit(1)
                    
                    HStack(spacing: 10) {
                        // Like/Unlike Button
                        Button(action: {
                            toggleLike(for: currentUserId)
                        }) {
                            Image(systemName: userHasLikedPost ? "heart.fill" : "heart")
                                .font(.system(size: 20))
                                .foregroundColor(userHasLikedPost ? .promPink : .black)
                        }
                        
                        // Display the number of likes
                        Text("\(likes.count)")
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(20)
                    .padding(.bottom)
                }
            }
        }
        .sheet(isPresented: $isViewingNote) {
            EditNoteView(note: note)
        }
        .onAppear {
            // Check if the current user has already liked the post
            userHasLikedPost = likes.contains(currentUserId)
        }
    }
    
    // Function to handle toggling likes
    func toggleLike(for userId: String) {
        if userHasLikedPost {
            // Remove like
            likes.removeAll { like in like == userId }
        } else {
            // Add like
            likes.append(userId)
        }
        
        // Update the state
        userHasLikedPost.toggle()
    }
}

#Preview {
    FeedListItem(note: Note6(postTitle: "Sample Title that has a bunch of text and this is eve", postBody: "Sample Body witha a bit more text faadsfadsf", ownerId: UUID().uuidString))
}
