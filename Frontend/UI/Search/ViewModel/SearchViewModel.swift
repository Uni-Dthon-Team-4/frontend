//
//  SearchViewModel.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import Foundation
import Combine

@Observable
class SearchViewModel {
    var text: String = ""
    var currentResult: UUID?
    private(set) var results: [SearchResult] = []
    private(set) var previousSearches: [String] = []
    private(set) var isCacheExist: Bool = false
    private let maxCacheSize: Int = 8
    private let responseSpeed = 200 //ms
    private var fileURL: URL? = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent("search.json", conformingTo: .json)
    }()
    
    func resetMessages() {
        saveCache()
        results.removeAll()
        loadCache()
    }
    
    func loadCache() {
        guard let fileURL else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            let cache = try JSONDecoder().decode(SearchCache.self, from: data)
            previousSearches = Array(cache.searches)
            isCacheExist = !cache.searches.isEmpty
        } catch {
            print("Fail to load search cache: \(error.localizedDescription)")
        }
    }
    
    func saveCache() {
        guard let fileURL else { fatalError("No search cache file") }
        
        previousSearches.append(contentsOf: results.map(\.search))
        if previousSearches.count > maxCacheSize {
            previousSearches.remove(atOffsets: IndexSet(0..<previousSearches.count-maxCacheSize))
        }
        let cache = SearchCache(
            searches: Set(previousSearches)
        )
        do {
            let data = try JSONEncoder().encode(cache)
            try data.write(to: fileURL)
        } catch {
            print("Fail to save search cache: \(error.localizedDescription)")
        }
    }
    
    func search() {
        guard !text.isEmpty else { return }
        let result = SearchResult(
            isError: false,
            isLoading: true,
            search: text,
            message: ""
        )
        results.append(result)
        text.removeAll()
        currentResult = result.id
        Task {
            do {
                let response = try await SearchService
                    .get(request: SearchRequest(prompt: result.search))
                animateResponse(from: response)
            } catch {
                setError()
                print("Fail to request chat api: \(error.localizedDescription)")
            }
        }
    }
    
    // 응답받은 메시지를 띄어쓰기단위로 쪼개 하나씩 보여줍니다.(애니메이션)
    private func animateResponse(from message: String) {
        let endIndex = results.endIndex-1
        if endIndex < 0 { return }
        let messageResponses = message.split(separator: " ", maxSplits: 100)
        for (index, response) in messageResponses.enumerated() {
            let duration = DispatchTimeInterval.milliseconds(responseSpeed*index)
            DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: duration)) { [weak self] in
                self?.results[endIndex].message.append(contentsOf: response)
            }
        }
        DispatchQueue.main.asyncAfter(
            deadline: .now().advanced(by: .milliseconds(responseSpeed*messageResponses.count))
        ) { [weak self] in
            self?.results[endIndex].isLoading = false
        }
    }
    
    private func setError() {
        let endIndex = results.endIndex-1
        if endIndex < 0 { return }
        results[endIndex].isError = true
    }
}
