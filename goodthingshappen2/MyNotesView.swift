//
//  MyNotesView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/23/24.
//

import SwiftUI
import SwiftData

struct MyNotesView: View {
    @Query var notes: [Note]
    @State var isAddingNewNote: Bool = false
    @State var isShowingPaywall: Bool = false
    
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "figure.wave.circle.fill")
                        Text("Hello there")
                            .frame(width: 340, alignment: .leading)
                    }
                    .padding()
                    
                    Text("My \nNotes")
                        .frame(width: 375, height: 200, alignment: .leading)
                        .padding()
                        .frame(width: 400, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(size: 80))
                    
                    List {
                        ForEach(notes) { note in
                            NoteListItem(note: note)
                        }
                    }
                }
            }
            
            // Floating button overlay
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    // "Try Premium" button
                    Button(action: {
                        isShowingPaywall = true
                    }) {
                        HStack {
                            Image(systemName: "sparkles")
                                .font(.system(size: 16))
                            Text("Try Premium")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.purple)
                        .clipShape(Capsule())
                        .shadow(radius: 10)
                    }
                    .sheet(isPresented: $isShowingPaywall) { AddNewNote(postTitle: "", postBody: "")
                    }
                    .padding(.trailing, 10)
                    
                    // Plus button
                    Button(action: {
                        isAddingNewNote = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .sheet(isPresented: $isAddingNewNote) { AddNewNote(postTitle: "", postBody: "")
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    MyNotesView()
}

