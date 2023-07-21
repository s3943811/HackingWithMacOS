//
//  ContentView.swift
//  FastTrack
//
//  Created by Maximus Dionyssopoulos on 21/7/2023.
//

import SwiftUI
import AVKit

struct ContentView: View {
    let gridItems: [GridItem] = [
        GridItem(.adaptive(minimum: 150, maximum: 200)),
    ]
    @AppStorage("searchText") var searchText = ""
    @State private var searches = [String]()
    @State private var selectedSearch = Set<String>()
    @State private var tracks = [Track]()
    @State private var audioPlayer: AVPlayer?
    enum SearchLocation {
        case formSubmit, onChange, none
    }
    @State private var searchLocation = SearchLocation.none
    enum SearchState {
        case none, searching, success, error
    }
    @State private var searchState = SearchState.none
    
    func performSearch() async throws {
        guard let safeSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(safeSearchText)&limit=100&entity=song") else {return}
        let (data, _) = try await URLSession.shared.data(from: url)
        let searchResults = try JSONDecoder().decode(SearchResult.self, from: data)
        tracks = searchResults.results
    }
    
    func startSearch() {
        searchState = .searching
        guard !searchText.isEmpty else {
            searchState = .none
            return
        }
        if searchLocation == .formSubmit && selectedSearch.contains(searchText) {
            searchState = .success
            return
        }
        
        if searches.contains(searchText) {
            let searchIndex = searches.firstIndex(of: searchText)!
            selectedSearch = [searches[searchIndex]]
        }
        Task {
            do {
                try await performSearch()
                searchState = .success
                if !searches.contains(searchText) {
                    searches.insert(searchText, at: 0)
                }
                selectedSearch = [searchText]
            } catch {
                searchState = .error
            }
        }
    }
    
    func play(_ track: Track) {
        audioPlayer?.pause()
        audioPlayer = AVPlayer(url: track.previewUrl)
        audioPlayer?.play()
    }
    
    var body: some View {
        NavigationSplitView {
            List(searches, id: \.self, selection: $selectedSearch) { search in
                Text(search)
                
            }

        } detail: {
            switch searchState {
            case .none:
                Text("Enter a search term to begin")
                    .frame(maxHeight: .infinity)
            case .searching:
                ProgressView()
                    .frame(maxHeight: .infinity)
            case .success:
                ScrollView() {
                    LazyVGrid(columns: gridItems) {
                        ForEach(tracks) { track in
                            TrackView(track: track, onSelected: play)
                        }
                    }
                    .padding()
                }
            case .error:
                Text("Sorry, your search failed - please check your internet connection then try again")
                    .frame(maxHeight: .infinity)
            }
        }
        .searchable(text: $searchText, placement: .toolbar)
        .onSubmit(of: .search) {
            searchLocation = .formSubmit
            startSearch()
        }
        .onChange(of: selectedSearch) { selected in
            guard searches.count != 1 else {return}
            searchLocation = .onChange
            searchText = selected.joined(separator: "")
            startSearch()
        }
        
    }
}

struct Track: Identifiable, Decodable {
    let trackId: Int
    let artistName: String
    let trackName: String
    let previewUrl: URL
    let artworkUrl100: String
    
    var id: Int {trackId}
    var artworkURL: URL? {
        let replacedString = artworkUrl100.replacingOccurrences(of: "100x100", with: "300x300")
        return URL(string: replacedString)
    }
}

struct SearchResult: Decodable {
    let results: [Track]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
