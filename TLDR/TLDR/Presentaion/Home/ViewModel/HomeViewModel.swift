//
//  HomeViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/10/05.
//

import Foundation

struct HomeViewModel {
    
    //MARK: - Properties
    let text: Observable<String> = Observable("")
    
    init() { }
    
    //MARK: - Methods
    func summarizeText() async throws -> SummarizeData {
        //서버에 summarize 요청 보내기
        let response = await postSummarize(language: .auto)
        
        //ok가 아니라면 에러 throw
        guard response.result == .ok else {
            throw HttpError.summarizeError(message: response.message)
        }
        
        //response 파싱
        let summarizeData = try parsingSummarizeData(response)
        
        return summarizeData
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
        
        let textKeywords: [String] = ["전체"] + parsingKeywords(responseData.textKeywords)
        let summarizeKeywords: [String] = ["전체"] + parsingKeywords(responseData.summarizeKeywords)

        let summarizeData = SummarizeData(text: text.value,
                                          summarizeText: responseData.summarize,
                                          textKeywords: textKeywords,
                                          summarizeKeywords: summarizeKeywords)

        return summarizeData
    }
    
    private func parsingKeywords(_ keywords: String) -> [String] {
        return keywords.components(separatedBy: "|")
                       .filter { !$0.isEmpty }
    }
    
    func updateText(_ text: String) {
        self.text.value = text
    }
    
    func resetText() {
        self.text.value = ""
    }
}
