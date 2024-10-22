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
    @State var likes: [String] = [] // Use this local state to track likes
    @State var likeCount: Int = 0 // Track the local like count

    var body: some View {
        let currentUserId = Auth.auth().currentUser?.uid ?? ""

        Button(action: {
            isViewingNote = true
        }) {
            ZStack {
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

                        Text("\(likeCount)")
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
            // Initialize the local likes array and count
            likes = note.likes
            likeCount = note.likes.count
            // Check if the current user has already liked the post
            userHasLikedPost = likes.contains(currentUserId)
        }
    }

    // Function to handle toggling likes
    func toggleLike(for userId: String) {
        if likes.contains(userId) {
            likes = likes.filter { $0 != userId }
            likeCount -= 1
        } else {
            likes.append(userId)
            likeCount += 1
        }
        
        // Update the database and toggle the like state
        updateLikesInDB(likesToSend: likes)
        userHasLikedPost.toggle()
    }

    func updateLikesInDB(likesToSend: [String]) {
        let noteId = note.id
        guard let url = URL(string: "https://sonant.net/api/notes/updateLikes") else {
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
        ] as [String: Any]

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
