//
//  SummarizeUseCase.swift
//  TLDR
//
//  Created by 유정주 on 2023/03/20.
//

import Foundation

struct SummarizeUseCase: SummarizeUseCaseProtocol {
    let repository: SummarizeRepositoryProtocol
    
    init(repository: SummarizeRepositoryProtocol) {
        self.repository = repository
    }
    
    func excute(requestValue: SummarizeRequestValue) async throws -> SummarizeResult {
        return try await repository.summarize(requestValue: requestValue)
    }
}
