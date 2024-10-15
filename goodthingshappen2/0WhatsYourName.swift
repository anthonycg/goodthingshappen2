//
//  0WhatsYourName.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/14/24.
//

import SwiftUI
import SwiftData
import FirebaseAuth

struct _WhatsYourName: View {
    @Environment(\.modelContext) var modelContext
    @Query var notes: [Note6]
    @Query var user: [User5]
    @State var name: String
    @State var email: String
    var body: some View {
        NavigationStack {
            ZStack {
                Color.champagnePink.ignoresSafeArea()
                VStack {
                    Text("What's your name?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                        .padding([.bottom], 20)
                    
                    TextField("Enter your name", text: $name)
                    
                    Divider()
                        .padding([.bottom], 40)
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                    }
                    .padding([.bottom], 20)
                    
                    // NavigationLink to MyNotesView
                    NavigationLink(destination: _ScheduleNotification()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 30)
                                .foregroundStyle(Color.black)
                                .shadow(radius: 5)
                            Text("Next")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.champagnePink)
                                .font(.headline)
                        }
                    }
                }
                .padding(50)
            }
        }
    }
    func UpdateName(user: User5) {
        user.name = name
        user.email = email
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("couldn't get userId")
            return
        }
        do {
            // Swift Data
            try modelContext.save()

            // DB
            
            
        } catch {
            print("Error saving updated user: \(error)")
        }

    }
}

#Preview {
    _WhatsYourName(name: "", email: "")
}
