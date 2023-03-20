//
//  HomeViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/10/05.
//

import Foundation

enum HomeViewModelActions {
    case summarize(String)
}

enum HomeViewModelActionOutputs {
    case summarize(SummarizeData)
    
    func value() -> Any {
        switch self {
        case .summarize(let summarizeData):
            return summarizeData
        }
    }
}

struct HomeViewModel {
    //todo: 의존성 주입
    private let summarizeUseCase: SummarizeUseCase = SummarizeUseCase(repository: SummarizeRepository())
    
    init() { }
    
    func action(_ actions: HomeViewModelActions) async throws -> HomeViewModelActionOutputs {
        switch actions {
        case .summarize(let text):
            return try await .summarize(summarize(text: text))
        }
    }
}

//MARK: - Actions
extension HomeViewModel {
    private func summarize(text: String, language: SummarizeLangauge = .auto) async throws -> SummarizeData {
        let requestValue = SummarizeRequestValue(text: createSentences(text), language: language)
        return try await summarizeUseCase.excute(requestValue: requestValue)
    }
    
    /**
     서버로 보낼 문장을 만듭니다.
     개행으로 끝나는 문장에 온점이 없는 경우 온점을 붙입니다.
     */
    private func createSentences(_ text: String) -> String {
        var newText: String = ""
        
        let strings = text.components(separatedBy: "\n")
        for string in strings {
            guard !string.isEmpty else {
                newText += "\n"
                continue
            }
            
            if let last = string.last, !(".?!".contains(last)) {
                newText += "\(string).\n"
            } else {
                newText += "\(string)\n"
            }
        }
        
        return newText
    }
}
