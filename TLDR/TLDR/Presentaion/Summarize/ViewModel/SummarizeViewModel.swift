//
//  summarizeViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/09.
//

import Foundation

struct SummarizeViewModel {
    
    //MARK: - Properties
    let data: Observable<SummarizeData> = Observable(SummarizeData())
    
    init() { }
    
    //MARK: - Methods
    func updateData(_ data: SummarizeData) {
        self.data.value = data
    }
    
    func getSummarizeText() -> String {
        return data.value.summarizeText
    }
    
    func getSummarizeKeywords() -> [String] {
        return data.value.summarizeKeywords
    }
    
    func getOriginalText() -> String {
        return data.value.text
    }
    
    func getOriginalKeywords() -> [String] {
        return data.value.textKeywords
    }
}
