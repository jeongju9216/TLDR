//
//  TextData.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/03.
//

import Foundation

//todo
//Wrap 클래스로 struct 최적화 하기
struct SummarizeResult: Hashable {
    let text: String //원본
    let summarizeText: String //요약 내용
    let textKeywords: [String]
    let summarizeKeywords: [String] //핵심 키워드
    
    init(text: String, summarizeText: String, textKeywords: [String], summarizeKeywords: [String]) {
        self.text = text
        self.summarizeText = summarizeText
        self.textKeywords = textKeywords
        self.summarizeKeywords = summarizeKeywords
    }
}

enum SummarizeLangauge: String {
    case auto //서버에서 자동 인식
    case en //영어로 번역
    case ko //한국어로 번역
}
