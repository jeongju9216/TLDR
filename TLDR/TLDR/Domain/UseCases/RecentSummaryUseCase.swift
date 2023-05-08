//
//  RecentSummaryUseCase.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/04.
//

import Foundation

struct RecentSummaryUseCase: RecentSummaryUseCaseProtocol {
    let repository: RecentSummaryRepositoryProtocol
    
    init(repository: RecentSummaryRepositoryProtocol) {
        self.repository = repository
    }
    
    func excute() throws -> [SummarizeResult] {
        return try repository.fetchRecentSummary()
    }
}

struct DeleteRecentSummaryUseCase: DeleteRecentSummaryUseCaseProtocol {
    let repository: RecentSummaryRepositoryProtocol
    
    init(repository: RecentSummaryRepositoryProtocol) {
        self.repository = repository
    }
    
    func excute() {
        repository.deleteAll()
    }
}
