//
//  HomeViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/10/05.
//

import Foundation

struct HomeViewModel {
    
    func postSummarize(text: String, language: SummarizeLangauge) async -> Response {
        return await HttpService.shard.postSummarize(text: text, language: language)
    }
    
    func parsingSummarizeData(_ response: Response, text: String) throws -> SummarizeData {
        guard let json = response.data else {
            throw HttpError.jsonError
        }

        Logger.info(json)

        let responseData: SummarizeResponseData = try SummarizeResponseData.decode(dictionary: json)
        
        let textKeywords: [String] = ["전체"] + responseData.textKeywords.components(separatedBy: "|").dropLast()
        let summarizeKeywords: [String] = ["전체"] + responseData.summarizeKeywords.components(separatedBy: "|").dropLast()

        let summarizeData = SummarizeData(text: text, summarizeText: responseData.summarize, textKeywords: textKeywords, summarizeKeywords: summarizeKeywords)

        return summarizeData
    }
}
