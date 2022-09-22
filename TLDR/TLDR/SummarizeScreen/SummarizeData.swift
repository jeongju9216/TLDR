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
    let keywords: Set<String> //핵심 키워드
}

enum SummarizeLangauge: String {
    case auto
    case en
    case kr
}
