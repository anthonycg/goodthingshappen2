//
//  NoteListItem.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/29/24.
//

import SwiftUI
import FirebaseAuth

struct FeedListItem: View {
    var note: NoteRetrieved
    @State var isViewingNote: Bool = false
    @State var userHasLikedPost: Bool = false
    @State var likes: [String] = []
    
    
    var body: some View {
        let currentUserId = Auth.auth().currentUser?.uid ?? ""
        
        Button(action: {
            isViewingNote = true
        }) {
            ZStack {
//                if let imageData = note.imageUrl,
//                      let uiImage = UIImage(data: imageData) {
//                       Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFill()  // Use scaledToFill to cover the area
//                        .frame(maxWidth: .infinity, minHeight: 265, maxHeight: 265) // Match the rectangle size
//                        .cornerRadius(30)
//                   }
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(
                        LinearGradient(colors: [.lightTeaGreen.opacity(0.8), .teaGreen.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(maxWidth: .infinity, minHeight: 265, maxHeight: 265)
                
                VStack(alignment: .leading) {
                    Text(note.posttitle.isEmpty ? "Untitled" : note.posttitle)
                        .frame(width: 330, height: 150, alignment: .bottomLeading)
                        .foregroundStyle(Color.black)
                        .font(.largeTitle)
                        .lineLimit(1)
                    
                    Text(note.postbody.isEmpty ? "No details yet." : note.postbody)
                        .frame(width: 330, height: 30, alignment: .bottomLeading)
                        .foregroundStyle(Color.black)
                        .font(.title3)
                        .lineLimit(1)
                    
                    HStack(spacing: 3) {
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
                            .padding([.trailing], 15)
                    
                        Text("\(note.username)")
                            .foregroundStyle(.black)
                    }
                    .padding(9)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                }
            }
        }
        .padding([.leading, .trailing])
        .sheet(isPresented: $isViewingNote) {
            FeedNoteView(note: note)
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
    FeedListItem(note: NoteRetrieved(id: "4242", posttitle: "Sample Title that has a bunch of text and this is eve", postbody: "Sample Body witha a bit more text faadsfadsf", imageurl: "", publicpost: false, ownerid: UUID().uuidString, likes: Likes(data: [123, 125]), createdat: "100", updatedat: "20", username: "Hello"))
}
