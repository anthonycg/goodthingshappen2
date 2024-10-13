//
//  FeedViewModel.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/13/24.
//

import Foundation
import SwiftUI
import Combine

class FeedViewModel: ObservableObject {
    @Published var notes: [NoteRetrieved] = []
    @Published var isLoading = false // Track loading state
    private var page = 1 // Start with the first page
    private let postsPerPage = 10
    
    func fetchNotes() {
        guard !isLoading else { return } // Avoid multiple requests
        isLoading = true
        
        guard let url = URL(string: "https://sonant.net/api/notes/?page=\(page)&limit=\(postsPerPage)") else {
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching notes: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }

            guard let data = data else {
                print("No data returned.")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            do {
                let newNotes = try JSONDecoder().decode([NoteRetrieved].self, from: data)
                DispatchQueue.main.async {
                    self.notes.append(contentsOf: newNotes) // Append new notes
                    self.page += 1 // Increment page for next fetch
                    self.isLoading = false // Reset loading state
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

