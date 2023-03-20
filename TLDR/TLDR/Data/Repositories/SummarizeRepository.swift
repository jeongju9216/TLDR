//
//  SummarizeRepository.swift
//  TLDR
//
//  Created by 유정주 on 2023/03/20.
//

import Foundation

final class SummarizeRepository: SummarizeRepositoryProtocol {
    func summarize(reqeustValue: SummarizeRequestValue) async throws -> SummarizeData {
        let param = ["text": reqeustValue.text, "language": reqeustValue.language.rawValue]
        
        let urlString = HttpService.shared.domain + HttpAPI.summarize.rawValue
        let response = await HttpService.shared.requestPost(url: urlString, param: param)
        
        let summarizeData = try parsingSummarizeData(response, originalText: reqeustValue.text)
        
        return summarizeData
    }
}

//MARK: - Parsing Response
extension SummarizeRepository {
    private func parsingSummarizeData(_ response: Response, originalText: String) throws -> SummarizeData {
        guard let json = response.data else {
            throw HttpError.jsonError
        }

        Logger.info(json)

        let responseData: SummarizeDataDTO = try SummarizeDataDTO.decode(dictionary: json)
        
        let summarizeData = responseData.toEntity(originalText: originalText)

        return summarizeData
    }
}
