//  NoteListItem.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/23/24.
//

import SwiftUI
import FirebaseAuth

struct NoteListItem: View {
    var note: Note6
    @Environment(\.modelContext) var modelContext
    @State var isEditingNote: Bool = false
    @State var uiImage: Image?
    @State var isPublic: Bool = false
    @State var showAlert: Bool = false
    @State private var showDeleteConfirmation = false
    @State private var showMakePublicConfirmation = false

    var body: some View {
        ZStack {
            // Check if imageData exists and is valid, then display the image
            if let imageData = note.imageURL,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()  // Use scaledToFill to cover the area
                    .frame(maxWidth: .infinity, minHeight: 265, maxHeight: 265) // Match the rectangle size
                    .clipped()
                    .cornerRadius(30)
            }

            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(
                    LinearGradient(colors: [.lightTeaGreen.opacity((uiImage != nil) ? 0.0 : 0.8), .teaGreen.opacity((uiImage != nil) ? 0.0 : 0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(maxWidth: .infinity, minHeight: 265, maxHeight: 265) // Maintain the frame
            
            VStack(alignment: .leading) {
                Text(note.postTitle.isEmpty ? "Untitled" : note.postTitle)
                    .frame(width: 330, height: 150, alignment: .bottomLeading)
                    .foregroundStyle(Color.black)
                    .font(.largeTitle)
                    .lineLimit(2)

                Text(note.postBody.isEmpty ? "No details yet..." : note.postBody)
                    .frame(width: 330, height: 30, alignment: .bottomLeading)
                    .foregroundStyle(Color.black)
                    .font(.title3)
                    .lineLimit(1)
                
                HStack(spacing: 50) {
                    Button(action: {
                        showMakePublicConfirmation = true // Show make public confirmation alert
                    }) {
                        Image(systemName: "network")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        isEditingNote = true
                    }) {
                        Image(systemName: "pencil")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        showDeleteConfirmation = true // Show delete confirmation alert
                    }) {
                        Image(systemName: "trash")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
                .padding(9)
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
            .padding() // Add some padding to the text for better readability
        }
        .sheet(isPresented: $isEditingNote) {
            EditNoteView(note: note)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Post Public!"),
                message: Text("Your post is now public."),
                dismissButton: .default(Text("Got it"))
            )
        }
        .alert(isPresented: $showDeleteConfirmation) { // Delete confirmation alert
            Alert(
                title: Text("Delete Note"),
                message: Text("Are you sure you want to delete this note?"),
                primaryButton: .destructive(Text("Delete")) {
                    deleteNote() // Call delete function if confirmed
                },
                secondaryButton: .cancel()
            )
        }
        .alert(isPresented: $showMakePublicConfirmation) { // Make public confirmation alert
            Alert(
                title: Text("Make Post Public"),
                message: Text("Are you sure you want to make this post public?"),
                primaryButton: .default(Text("Yes")) {
                    makePostPublic() // Call make public function if confirmed
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    func makePostPublic() {
        guard let url = URL(string: "https://sonant.net/api/notes/create") else {
            print("Invalid URL")
            return
        }
        
        guard let user = Auth.auth().currentUser else {
            print("Error: User not authenticated")
            return
        }
        
        var imageBase64String: String? = nil
        if let imageData = note.imageURL {
            imageBase64String = imageData.base64EncodedString() // Convert image data to base64
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print("Note ID: \(note.id)")
        print("Post Title: \(note.postTitle)")
        print("ImageURL: \(String(describing: uiImage))")

        let note = [
            "id": note.id.uuidString,
            "postTitle": note.postTitle,
            "postBody": note.postBody,
            "imageUrl": "",
            "likes": [],
            "ownerId": user.uid,
            "publicPost": true
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

            print("Note created successfully")
            
            DispatchQueue.main.async {
                isPublic = true
                showAlert = true
            }

        }
        task.resume()
    }
    
    func deleteNote() {
        modelContext.delete(note)
            
        do {
            try modelContext.save()
        } catch {
            print("Failed to delete note:", error)
        }
    }
}

#Preview {
    NoteListItem(note: Note6(postTitle: "Sample Title that has a bunch of text and this is eve", postBody: "Sample Body with a bit more text faadsfadsf", ownerId: UUID().uuidString))
}

