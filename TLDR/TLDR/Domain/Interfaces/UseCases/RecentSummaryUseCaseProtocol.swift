//
//  RecentSummaryUseCaseProtocol.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/04.
//

import Foundation

protocol RecentSummaryUseCaseProtocol {
    associatedtype ResponseType
    var repository: RecentSummaryRepositoryProtocol { get }
    
    func excute() throws -> ResponseType
}

protocol DeleteRecentSummaryUseCaseProtocol {
    var repository: RecentSummaryRepositoryProtocol { get }
    
    func excute()
}
