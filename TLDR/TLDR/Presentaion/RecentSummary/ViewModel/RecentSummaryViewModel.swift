//
//  RecentSummaryViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/05.
//

import Foundation

enum RecentSummaryViewModelActions {
    case recentSummary
}

enum RecentSummaryViewModelActionOutputs {
    case recentSummary([SummarizeResult])
    
    func value() -> Any {
        switch self {
        case .recentSummary(let recentSummaries):
            return recentSummaries
        }
    }
}

struct RecentSummaryViewModel {
    private let recentSummaryUseCase: RecentSummaryUseCase = RecentSummaryUseCase(repository: RecentSummaryRepository())
    
    init() { }
    
    func action(_ actions: RecentSummaryViewModelActions) throws -> RecentSummaryViewModelActionOutputs {
        switch actions {
        case .recentSummary:
            return try .recentSummary(fetchRecentSummary())
        }
    }
}

extension RecentSummaryViewModel {
    //최근 요약 기록
    private func fetchRecentSummary() throws -> [SummarizeResult] {
        return try recentSummaryUseCase.excute()
    }
}
