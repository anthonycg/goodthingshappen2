//
//  FeedView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/29/24.
//

import SwiftUI
import RevenueCat
import RevenueCatUI
import SwiftData

struct FeedView: View {
    @Environment(\.modelContext) var modelContext
    @Query var notes: [Note6]
    
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            LazyVStack {
                ForEach (notes) {
                    note in
                    FeedListItem(note: note, isViewingNote: false)
                }
            }
        }
        
    }
}

#Preview {
    FeedView()
}
