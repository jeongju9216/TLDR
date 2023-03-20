//
//  SummarizeUseCaseProtocol.swift
//  TLDR
//
//  Created by 유정주 on 2023/03/20.
//

import Foundation

protocol SummarizeUseCaseProtocol {
    associatedtype RequestType
    associatedtype ResponseType
    var repository: SummarizeRepositoryProtocol { get }
    
    func excute(requestValue: RequestType) async throws -> ResponseType
}
