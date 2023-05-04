//
//  RecentSummaryRepositoryProtocol.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/04.
//

import Foundation

protocol RecentSummaryRepositoryProtocol {
    func fetchRecentSummary() throws -> [SummarizeResult]
}
