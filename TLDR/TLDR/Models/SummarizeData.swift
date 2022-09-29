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
    let keywords: [String] //핵심 키워드
    
    init() {
        self.text = ""
        self.summarizeText = ""
        self.keywords = []
    }
    
    init(text: String, summarizeText: String, keywords: [String]) {
        self.text = text
        self.summarizeText = summarizeText
        self.keywords = keywords
    }
}

struct SummarizeResponseData: Decodable {
    let summarize: String
    let keywords: String
    let language: String
}

enum SummarizeLangauge: String {
    case auto //서버에서 자동 인식
    case en //영어로 번역
    case ko //한국어로 번역
}
