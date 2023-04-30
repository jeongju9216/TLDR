//
//  SummarizeRepository.swift
//  TLDR
//
//  Created by 유정주 on 2023/03/20.
//

import Foundation

final class WrappedSummarizeResult {
    let summarizeResult: SummarizeResult
    init(summarizeResult: SummarizeResult) {
        self.summarizeResult = summarizeResult
    }
}

final class SummarizeRepository: SummarizeRepositoryProtocol, Loggable {
    //todo: NSCache -> URLCache로 변경하기
    //Response를 캐싱할 수 있기 때문에 구조체 Wrapping 과정도 줄일 수 있고, 의도에도 적절함
    //또한, 메모리 캐시와 디스크 캐시를 함께 지원한다는 장점도 있음
    private var memoryCache = NSCache<NSString, WrappedSummarizeResult>()
    private var summarizeResultStorage = SummarizeResultStorage()
}

//MARK: - API Call
extension SummarizeRepository {
    func summarize(requestValue: SummarizeRequestValue) async throws -> SummarizeResult {
        if let cache = memoryCache.object(forKey: NSString(string: requestValue.text)) {
            jlog(.debug ,"fetch Data from Memory Cache")
            return cache.summarizeResult
        }
        
        if let diskCache = summarizeResultStorage.fetch(text: requestValue.text) {
            jlog(.debug ,"fetch Data from Disk Cache")
            return diskCache
        }
        
        let param = ["text": requestValue.text, "language": requestValue.language.rawValue]
        
        let urlString = HttpService.shared.domain + HttpAPI.summarize.rawValue
        let response = await HttpService.shared.requestPost(url: urlString, param: param)
        
        let summarizeData = try parsingSummarizeData(response, originalText: requestValue.text)
        summarizeResultStorage.save(summarizeData)
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

        jlog(.debug, json)

        let responseData: SummarizeDataDTO = try SummarizeDataDTO.decode(dictionary: json)
        
        let summarizeData = responseData.toEntity(originalText: originalText)

        return summarizeData
    }
}
