//
//  TextData.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/03.
//

import Foundation

struct SummarizeData {
    let text: String //원본
    let summarizeText: String //요약 내용
    let textKeywords: [String]
    let summarizeKeywords: [String] //핵심 키워드
    
    init() {
        self.text = ""
        self.summarizeText = ""
        self.textKeywords = []
        self.summarizeKeywords = []
    }
    
    init(text: String, summarizeText: String, textKeywords: [String], summarizeKeywords: [String]) {
        self.text = text
        self.summarizeText = summarizeText
        self.textKeywords = textKeywords
        self.summarizeKeywords = summarizeKeywords
    }
}

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

enum SummarizeLangauge: String {
    case auto //서버에서 자동 인식
    case en //영어로 번역
    case ko //한국어로 번역
}
