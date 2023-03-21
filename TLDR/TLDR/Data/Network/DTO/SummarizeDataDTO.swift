//
//  SummarizeDataDTO.swift
//  TLDR
//
//  Created by 유정주 on 2023/03/19.
//

import Foundation

struct SummarizeDataDTO: Codable {
    let summarize: String
    let textKeywords: String
    let summarizeKeywords: String
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case summarize
        case textKeywords = "text_keywords"
        case summarizeKeywords = "summarize_keywords"
        case language
    }
    
    func toEntity(originalText: String) -> SummarizeResult {
        return .init(text: originalText,
                     summarizeText: summarize,
                     textKeywords: ["전체"] + parsingKeywords(textKeywords),
                     summarizeKeywords: ["전체"] + parsingKeywords(summarizeKeywords))
    }
    
    private func parsingKeywords(_ keywords: String) -> [String] {
        return keywords.components(separatedBy: "|")
                       .filter { !$0.isEmpty }
    }
}
