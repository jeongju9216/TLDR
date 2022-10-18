//
//  HomeViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/10/05.
//

import Foundation

struct HomeViewModel {
    let text: Observable<String> = Observable("")
    
    init() { }
    
    func updateText(_ text: String) {
        self.text.value = text
    }
    
    func resetText() {
        self.text.value = ""
    }
    
    func postSummarize(language: SummarizeLangauge) async -> Response {
        let newText: String = createSentences()
        
        return await HttpService.shard.postSummarize(text: newText, language: language)
    }
    
    /**
     서버로 보낼 문장을 만듭니다.
     개행으로 끝나는 문장에 온점이 없는 경우 온점을 붙입니다.
     */
    func createSentences() -> String {
        var newText: String = ""
        
        let strings = text.value.components(separatedBy: "\n")
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
    
    func parsingSummarizeData(_ response: Response) throws -> SummarizeData {
        guard let json = response.data else {
            throw HttpError.jsonError
        }

        Logger.info(json)

        let responseData: SummarizeResponseData = try SummarizeResponseData.decode(dictionary: json)
        
        let textKeywords: [String] = ["전체"] + responseData.textKeywords.components(separatedBy: "|").filter { !$0.isEmpty }
        let summarizeKeywords: [String] = ["전체"] + responseData.summarizeKeywords.components(separatedBy: "|").filter { !$0.isEmpty }

        let summarizeData = SummarizeData(text: text.value, summarizeText: responseData.summarize, textKeywords: textKeywords, summarizeKeywords: summarizeKeywords)

        return summarizeData
    }
}
