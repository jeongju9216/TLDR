//
//  RecentSummaryViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/05.
//

import Foundation

enum RecentSummaryViewModelActions {
    case recentSummary
    case deleteAll
}

enum RecentSummaryViewModelActionOutputs {
    case recentSummary([SummarizeResult])
    case deleteAll([SummarizeResult])
    
    func value() -> Any {
        switch self {
        case .recentSummary(let recentSummaries):
            return recentSummaries
        case .deleteAll(let list):
            return list
        }
    }
}

struct RecentSummaryViewModel {
    private let recentSummaryUseCase: RecentSummaryUseCase = RecentSummaryUseCase(repository: RecentSummaryRepository())
    private let deleteRecentSummaryUseCase: DeleteRecentSummaryUseCase = DeleteRecentSummaryUseCase(repository: RecentSummaryRepository())
    
    init() { }
    
    @discardableResult
    func action(_ actions: RecentSummaryViewModelActions) throws -> RecentSummaryViewModelActionOutputs {
        switch actions {
        case .recentSummary:
            return try .recentSummary(fetchRecentSummary())
        case .deleteAll:
            return .deleteAll(deleteAll())
        }
    }
}

extension RecentSummaryViewModel {
    //최근 요약 기록
    private func fetchRecentSummary() throws -> [SummarizeResult] {
        return try recentSummaryUseCase.excute()
    }
    
    //모든 최근 요약 기록 삭제
    private func deleteAll() -> [SummarizeResult] {
        deleteRecentSummaryUseCase.excute()
        return []
    }
}
