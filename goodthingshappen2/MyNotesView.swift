//
//  MyNotesView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/23/24.
//

import SwiftUI
import SwiftData
import RevenueCat
import RevenueCatUI

struct MyNotesView: View {
    @Query var notes: [Note3]
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    
                    Text("My \nNotes")
                        .foregroundColor(.black)
                        .font(.system(size: 80))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Use a VStack instead of List
                    VStack {
                        ForEach(notes) { note in
                            NoteListItem(note: note)
                        }
                    }
                    .padding(.horizontal)
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
                        .background(Color.promPink)
                        .clipShape(Capsule())
                        .shadow(color: Color.pinkLace, radius: 4, y: 12)
                    }
                    .sheet(isPresented: $isShowingPaywall) {
                        PaywallView(displayCloseButton: true)
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
                            .background(Color.accentColor)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .sheet(isPresented: $isAddingNewNote) {
                        // Consider adding parameters if necessary
                        AddNewNote(postTitle: "", postBody: "")
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
