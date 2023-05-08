//
//  RecentSummaryRepository.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/04.
//

import Foundation

final class RecentSummaryRepository: RecentSummaryRepositoryProtocol {
    private var summarizeResultStorage = SummarizeResultStorage()
}

extension RecentSummaryRepository {
    func fetchRecentSummary() -> [SummarizeResult] {
        return summarizeResultStorage.fetch()
    }
    
    func deleteAll() {
        summarizeResultStorage.deleteAll()
    }
}
