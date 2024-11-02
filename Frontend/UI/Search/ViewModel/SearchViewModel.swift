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
    private(set) var previousPolicies: [RelevantPolicy] = []
    private(set) var previousKeywords: [String] = []
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
            previousKeywords = Array(cache.keywords)
            previousPolicies = Array(cache.policies)
            isCacheExist = !cache.searches.isEmpty || !cache.keywords.isEmpty || !cache.policies.isEmpty
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
        previousKeywords.append(contentsOf: results.flatMap(\.keywords))
        if previousKeywords.count > maxCacheSize {
            previousKeywords.remove(atOffsets: IndexSet(0..<previousKeywords.count-maxCacheSize))
        }
        previousPolicies.append(contentsOf: results.flatMap(\.policies))
        if previousPolicies.count > maxCacheSize {
            previousPolicies.remove(atOffsets: IndexSet(0..<previousPolicies.count-maxCacheSize))
        }
        let cache = SearchCache(
            searches: Set(previousSearches),
            keywords: Set(previousKeywords),
            policies: Set(previousPolicies)
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
            isLoading: true,
            search: text,
            message: "",
            keywords: [],
            policies: []
        )
        results.append(result)
        text.removeAll()
        currentResult = result.id
        // Load from api
        
        animateResponse(from: """
### 서울시는 1인가구를 위해 다양한 지원 정책을 제공하고 있습니다. 주요 프로그램은 다음과 같습니다: \n

1. **병원 안심동행 서비스**: 혼자 병원 방문이 어려운 시민을 위해 동행 매니저가 병원 출발부터 귀가까지 동행하며 접수, 수납, 약품 수령 등을 지원합니다. 이용료는 시간당 5,000원이며, 중위소득 100% 이하 시민은 연간 48회까지 무료로 이용할 수 있습니다. (Seoul News)\n

2. 전월세 안심계약 도움서비스: 부동산 계약에 익숙하지 않은 1인가구를 위해 주거안심매니저가 전월세 계약 상담과 집보기 동행 등의 도움을 제공합니다. 평일뿐만 아니라 토요일에도 시범 운영하여 직장인들의 이용 편의를 높이고 있습니다. (Seoul News)\n

이 외에도 서울시는 1인가구의 생활 안정을 위해 다양한 정책을 추진하고 있습니다. 자세한 내용은 서울시 1인가구 포털 ‘씽글벙글 서울’에서 확인하실 수 있습니다. 
""")
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
}
