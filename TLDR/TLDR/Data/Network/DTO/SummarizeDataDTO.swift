//
//  SummarizeDataDTO.swift
//  TLDR
//
//  Created by 유정주 on 2023/03/19.
//

import Foundation

struct SummarizeResponseData: Codable {
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
}
