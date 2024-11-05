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
    @Environment(\.modelContext) var modelContext
    @Query var notes: [Note6]
    @Query var user: [User5]
    @State var isAddingNewNote: Bool = false
    @Binding var isShowingPaywall: Bool
    @State var isShowingLocalPaywall: Bool = false
    
    @State private var isSubscribed: Bool = false // New state for subscription status
    
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "figure.wave.circle.fill")
                            .foregroundStyle(.black)
                        Text("Hello, \(user.first?.name ?? "Hello there")")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.black)
                    }
                    .padding()
                    
                    Text("My \nNotes")
                        .foregroundColor(.black)
                        .font(.system(size: 80))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Display notes
                    VStack {
                        ForEach(notes.reversed()) { note in
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
                    
                    // "Try Premium" button, shown only if not subscribed
                    if !isSubscribed {
                        Button(action: {
                            isShowingLocalPaywall = true
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
                            .shadow(color: Color.pinkLace, radius: 10)
                        }
                        .sheet(isPresented: $isShowingLocalPaywall) {
                            PaywallView(displayCloseButton: true)
                        }
                        .padding(.trailing, 10)
                    }
                    
                    // Plus button
                    Button(action: {
                        isAddingNewNote = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.teaGreen)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .fullScreenCover(isPresented: $isAddingNewNote) {
                        AddNewNote(postTitle: "", postBody: "")
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            fetchSubscriptionStatus()
        }
    }
    
    // Check the user's subscription status with RevenueCat
    func fetchSubscriptionStatus() {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if let error = error {
                print("Error fetching subscription status: \(error)")
            } else if let customerInfo = customerInfo {
                // Check if the user is subscribed
                isSubscribed = customerInfo.entitlements["premium"]?.isActive == true
            }
        }
    }
}

#Preview {
    @Previewable @State var isShowingPrePaywall = false
    return MyNotesView(isShowingPaywall: $isShowingPrePaywall)
}
