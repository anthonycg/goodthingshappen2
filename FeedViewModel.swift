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

    func fetchNotes() {
        guard let url = URL(string: "https://sonant.net/api/notes/") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching notes: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data returned.")
                return
            }
            
//            // Log the raw response
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON response: \(jsonString)")
//            }

            do {
                let notes = try JSONDecoder().decode([NoteRetrieved].self, from: data)
                DispatchQueue.main.async {
                    self.notes = notes
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
        print("Fetched notes: \(notes)")

    }



    private var cancellables = Set<AnyCancellable>() 
}
