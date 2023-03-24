//
//  SummarizeRepositoryProtocol.swift
//  TLDR
//
//  Created by 유정주 on 2023/03/20.
//

import Foundation

struct SummarizeRequestValue {
    let text: String
    let language: SummarizeLangauge
}

protocol SummarizeRepositoryProtocol {
    func summarize(requestValue: SummarizeRequestValue) async throws -> SummarizeResult
}
