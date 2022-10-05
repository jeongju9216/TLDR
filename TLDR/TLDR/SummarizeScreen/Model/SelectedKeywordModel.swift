//
//  KeywordModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/10/05.
//

import Foundation

struct SelectedKeywordModel {
    var prevIndex: Int = 0
    var keywords: Set<String> = []
    
    mutating func insertKeyword(_ keyword: String, index: Int) {
        keywords.insert(keyword)
        prevIndex = index
    }
    
    mutating func removeKeyword(_ keyword: String) {
        keywords.remove(keyword)
    }
    
    mutating func removeAll() {
        keywords.removeAll()
    }
}
