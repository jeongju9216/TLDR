//
//  KeywordViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/22.
//

import UIKit

struct KeywordViewModel {
    let keywords: Observable<[String]> = Observable([])
    
    init() { }
    
    init(_ keywords: [String]) { //처음은 전체 키워드 넣기
        self.keywords.value = keywords
    }
    
    func clickedKeyword(_ keywords: [String]) { //선택한 키워드
        self.keywords.value = keywords
    }
}
