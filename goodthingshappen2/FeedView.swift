//
//  FeedView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/29/24.
//

import SwiftUI
import Combine

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.notes) { note in
                        FeedListItem(note: note, isViewingNote: false)
                    }
                    
                    // Show progress indicator while loading more posts
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
                .padding(.bottom)
                .onAppear {
                    if viewModel.notes.isEmpty {
                        viewModel.fetchNotes() // Fetch initial posts
                    }
                }
                .onAppear(perform: loadMoreNotesIfNeeded)
            }
        }
    }

    // Function to detect when to load more notes
    private func loadMoreNotesIfNeeded() {
        if !viewModel.isLoading {
            viewModel.fetchNotes() // Fetch next set of posts
        }
    }
}

