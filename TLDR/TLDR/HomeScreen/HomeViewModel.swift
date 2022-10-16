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
        return await HttpService.shard.postSummarize(text: text.value, language: language)
    }
    
    func parsingSummarizeData(_ response: Response) throws -> SummarizeData {
        guard let json = response.data else {
            throw HttpError.jsonError
        }

        Logger.info(json)

        let responseData: SummarizeResponseData = try SummarizeResponseData.decode(dictionary: json)
        
        let textKeywords: [String] = ["전체"] + responseData.textKeywords.components(separatedBy: "|").dropLast()
        let summarizeKeywords: [String] = ["전체"] + responseData.summarizeKeywords.components(separatedBy: "|").dropLast()

        let summarizeData = SummarizeData(text: text.value, summarizeText: responseData.summarize, textKeywords: textKeywords, summarizeKeywords: summarizeKeywords)

        return summarizeData
    }
}
