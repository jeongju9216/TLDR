//
//  KeywordViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/29.
//

import Foundation

struct KeywordViewModel {
    //중복 제거를 위해 Set으로 선언
    let keywords: Observable<Set<String>> = Observable([])
    
    init() { }
    
    init(_ keywords: Set<String>) { //처음은 전체 키워드 넣기
        self.keywords.value = keywords
    }
    
    //선택한 키워드
    func setKeywords(_ keywords: Set<String>) {
        self.keywords.value = keywords
    }
    
    func selectedKeyword(_ keyword: String) {
        self.keywords.value.insert(keyword)
    }
    
    //선택 해제한 키워드
    func unselectedKeyword(_ keyword: String) {
        self.keywords.value.remove(keyword)
    }
}
