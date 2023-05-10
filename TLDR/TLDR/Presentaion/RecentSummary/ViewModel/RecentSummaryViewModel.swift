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

final class RecentSummaryViewModel {
    @Published private(set) var recentSummaries: [SummarizeResult] = []
    
    private let recentSummaryUseCase: RecentSummaryUseCase = RecentSummaryUseCase(repository: RecentSummaryRepository())
    private let deleteRecentSummaryUseCase: DeleteRecentSummaryUseCase = DeleteRecentSummaryUseCase(repository: RecentSummaryRepository())
    
    init() { }
    
    func action(_ actions: RecentSummaryViewModelActions) throws {
        switch actions {
        case .recentSummary:
            try fetchRecentSummary()
        case .deleteAll:
            deleteAll()
        }
    }
}

extension RecentSummaryViewModel {
    //최근 요약 기록
    private func fetchRecentSummary() throws {
        recentSummaries = try recentSummaryUseCase.excute()
    }
    
    //모든 최근 요약 기록 삭제
    private func deleteAll() {
        deleteRecentSummaryUseCase.excute()
        recentSummaries = []
    }
}
