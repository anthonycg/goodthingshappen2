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
    @Query var notes: [Note4]
    
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
//        .fullScreenCover(item: $hasPremium, content: PaywallView(displayCloseButton: false))
        
    }
}

#Preview {
    FeedView()
}
