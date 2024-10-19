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
                        Text("\(note.likes.count)")
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
        if (note.likes.contains(userId)) {
            // remove userId
            var currentLikes = note.likes // This an array of Strings
            var updatedLikes = currentLikes.filter {
                $0 != userId
            }
            updateLikesInDB(likesToSend: updatedLikes)
        } else {
            // append userId
            var currentLikes = note.likes
            var updatedLikes = currentLikes + [userId]
            
            updateLikesInDB(likesToSend: updatedLikes)
        }
        
//        if userHasLikedPost {
//            // Remove like
//            likes.removeAll { like in like == userId }
//        } else {
//            // Add like
//            likes.append(userId)
//        }
        
        // Update the state
        userHasLikedPost.toggle()
    }
    
    func updateLikesInDB(likesToSend: [String]) {
        let noteId = note.id
        
        guard let url = URL(string: "https://sonant.net/api/notes/update") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
            print("Note ID: \(noteId)")
            print("Likes: \(likesToSend)")

        let note = [
            "id": noteId,
            "likes": likesToSend
        ] as [String : Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: note, options: [])
        } catch {
            print("Error serializing JSON:", error)
            return
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request:", error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Unexpected response:", response ?? "No response")
                return
            }
            
            if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                print("Response body: \(responseBody)")
            }
        }
        
        task.resume()
    }
}

#Preview {
    FeedListItem(note: NoteRetrieved(id: "4242", posttitle: "Sample Title that has a bunch of text and this is eve", postbody: "Sample Body witha a bit more text faadsfadsf", imageurl: "", publicpost: false, ownerid: UUID().uuidString, likes: [], createdat: "100", updatedat: "20", username: "Hello"))
}
