//
//  SummarizeRepository.swift
//  TLDR
//
//  Created by 유정주 on 2023/03/20.
//

import Foundation
import JeongLogger

final class WrappedSummarizeResult {
    let summarizeResult: SummarizeResult
    init(summarizeResult: SummarizeResult) {
        self.summarizeResult = summarizeResult
    }
}

final class SummarizeRepository: SummarizeRepositoryProtocol {
    private var memoryCache = NSCache<NSString, WrappedSummarizeResult>()
}

//MARK: - API Call
extension SummarizeRepository {
    func summarize(requestValue: SummarizeRequestValue) async throws -> SummarizeResult {
        if let cache = memoryCache.object(forKey: NSString(string: requestValue.text)) {
            return cache.summarizeResult
        }
        
        let param = ["text": requestValue.text, "language": requestValue.language.rawValue]
        
        let urlString = HttpService.shared.domain + HttpAPI.summarize.rawValue
        let response = await HttpService.shared.requestPost(url: urlString, param: param)
        
        let summarizeData = try parsingSummarizeData(response, originalText: requestValue.text)
        memoryCache.setObject(.init(summarizeResult: summarizeData), forKey: NSString(string: requestValue.text))
        
        return summarizeData
    }
}

//MARK: - Parsing Response
extension SummarizeRepository {
    private func parsingSummarizeData(_ response: Response, originalText: String) throws -> SummarizeResult {
        guard let json = response.data else {
            throw HttpError.jsonError
        }

        JeongLogger.log(json, level: .info)

        let responseData: SummarizeDataDTO = try SummarizeDataDTO.decode(dictionary: json)
        
        let summarizeData = responseData.toEntity(originalText: originalText)

        return summarizeData
    }
}
