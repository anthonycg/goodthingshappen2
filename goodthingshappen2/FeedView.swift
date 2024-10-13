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
    @State private var page = 1
    @State private var isLoading = false
    private let postsPerPage = 10
    
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.notes) { note in
                        FeedListItem(note: note, isViewingNote: false)
                    }
                    
                    if isLoading {
                        ProgressView()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchNotes()
        }
    }
}

#Preview {
    FeedView()
}

