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
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var notes: [Note6]
    
    @State var postTitle: String
    @State var postBody: String
    @State var isShowingImagePicker: Bool = false
    @State var inputImage: UIImage?
    @State var image: Image?
    
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
                                isShowingImagePicker = true
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
                
                Spacer()
            }
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
