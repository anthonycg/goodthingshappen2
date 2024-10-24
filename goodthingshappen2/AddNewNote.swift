//
//  AddNewNote.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/24/24.
//

import SwiftUI
import SwiftData
import FirebaseAuth
import RevenueCatUI
import RevenueCat

struct AddNewNote: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var notes: [Note6]
    
    @State var postTitle: String
    @State var postBody: String
    @State var isShowingImagePicker: Bool = false
    @State var inputImage: UIImage?
    @State var image: Image?
    @State var showPaywall: Bool = false
    
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    
    var body: some View {
        ZStack {
            ZStack {
                // Use the inputImage if it's available; otherwise, show no image
                if let uiImage = inputImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .ignoresSafeArea()
                }
                
                Color.champagnePink.ignoresSafeArea().opacity((image != nil) ? 0.9 : 0.8)
            }
            
            VStack {
                TextField("Title your day...", text: $postTitle, axis: .vertical)
                    .font(.system(size: 40))
                    .lineLimit(3)
                    .padding([.leading, .trailing])
                
                Spacer()
                
                VStack {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Image(systemName: "pencil.line")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            
                            Text("What good thing happened today?")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding(.top, 10)

                        VStack {
                            TextField("Write about the details of today...", text: $postBody, axis: .vertical)
                                .lineLimit(16)
                                .padding([.top, .bottom], 30)
                                .background(Color.green.opacity(0))
                                .cornerRadius(10)
                        }

                        HStack(spacing: 30) {
                            Button(action: {
                                if subscriptionManager.isPremium {
                                    isShowingImagePicker = true
                                } else {
                                   showPaywall = true
                                }
                            }) {
                                Image(systemName: "camera")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {
                                Task {
                                       await saveNote()
                                   }
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
                    }
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.lightTeaGreen, Color.teaGreen]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(30)
                    .padding()
                    .shadow(radius: 10)
                }
                .onChange(of: inputImage) {
                    loadImage()
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                .sheet(isPresented: $showPaywall) {
                    PaywallView()
                }
                
                Spacer()
            }
        }
    }

    func saveNote() async {
        guard !postTitle.isEmpty, !postBody.isEmpty else {
            print("Title and body cannot be empty")
            return
        }
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated")
            return
        }
        
        let note = Note6(postTitle: postTitle, postBody: postBody, ownerId: userId)
        
        if let inputImage = inputImage {
            note.imageURL = inputImage.pngData()
        }
        
        modelContext.insert(note)
        do {
            try modelContext.save()
        } catch {
            print("Failed to insert note")
        }
        
        //If user is subscribed, save note to DB
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            if customerInfo.entitlements["premium"]?.isActive == true {
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

                }
                task.resume()
            }
        } catch {
            // handle error
        }
        
        
        // Reset the inputImage and other states
        inputImage = nil
        image = nil
        postTitle = ""
        postBody = ""
        
        dismiss()
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

#Preview {
    AddNewNote(postTitle: "", postBody: "")
        .modelContainer(for: [Note6.self, User5.self])
}
