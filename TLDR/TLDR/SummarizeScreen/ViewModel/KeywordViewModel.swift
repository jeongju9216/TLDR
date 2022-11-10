//
//  KeywordViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/29.
//

import Foundation

struct KeywordViewModel {
    //중복 제거를 위해 Set으로 선언
    //MARK: - Properties
    let keywords: Observable<[String]> = Observable([])
    let selectedKeywords: Observable<SelectedKeywordModel> = Observable(SelectedKeywordModel())
        
    init() { }

    //MARK: - Methods
    //MARK: Keyword
    func updateTotalKeywords(_ keywords: [String]) {
        self.keywords.value = keywords
    }
    
    func getKeyword(index: Int) -> String {
        return self.keywords.value[index]
    }
    
    func getTotalKeywords() -> [String] {
        return self.keywords.value
    }
    
    func getTotalKeywordsCount() -> Int {
        return keywords.value.count
    }
    
    //MARK: selectedKeywords
    func selected(index: Int) {
        selectedKeywords.value.insertKeyword(getKeyword(index: index), index: index)
    }
    
    func selectedKeyword(_ keyword: String, index: Int) {
        selectedKeywords.value.insertKeyword(keyword, index: index)
    }
    
    //선택 해제한 키워드
    func deselected(index: Int) {
        selectedKeywords.value.removeKeyword(getKeyword(index: index))
    }
    
    func deselectedKeyword(_ keyword: String) {
        selectedKeywords.value.removeKeyword(keyword)
    }
    
    //"전체" 키워드 선택
    func selectAll() {
        selectedKeywords.value = SelectedKeywordModel(prevIndex: 0, keywords: Set(keywords.value))
    }
    
    //전체 키워드 해제
    func deselectAll() {
        selectedKeywords.value.removeAll()
    }
    
    func getPrevSelectedIndex() -> Int {
        return selectedKeywords.value.prevIndex
    }
}
