//
//  APIService.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/20.
//

import Foundation

enum Result: String, Codable {
    case ok = "ok"
    case fail = "fail"
}

struct Response: Codable {
    let result: Result
    let message: String
    let data: [String: String]?
}

final class HttpService {
    static let shard: HttpService = HttpService()
    private init() { }

    private let urlSession: URLSession = URLSession.shared
    private let domain: String = "https://tldr161718.site/" //"http://44.210.126.152/"//
    
    //GET
    func getVersion() async -> Response {
        let response = await requestGet(url: self.domain + HttpAPI.version.rawValue)
        return response
    }
    
    func getState() async -> Response {
        let response = await requestGet(url: self.domain + HttpAPI.state.rawValue)
        return response
    }
    
    //POST
    func postSummarize(text: String, language: SummarizeLangauge) async -> Response {
        let param = ["text": text, "language": language.rawValue]
        let response = await requestPost(url: self.domain + HttpAPI.summarize.rawValue, param: param)
        return response
    }
}

extension HttpService {
    private func requestGet(url: String) async -> Response {
        do {
            Logger.debug(url)
            guard let url = URL(string: url) else { throw HttpError.urlError }
                        
            let (data, response) = try await urlSession.data(from: url)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                throw HttpError.statusCodeError
            }
                
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            Logger.error(error)
            return Response(result: .fail, message: error.localizedDescription, data: nil)
        }
    }
    
    private func requestPost(url: String, param: [String: Any]) async -> Response {
        do {
            Logger.debug(url)
            Logger.debug(param)
            guard let sendData = try? JSONSerialization.data(withJSONObject: param, options: [.prettyPrinted]) else { throw HttpError.jsonError }
            
            guard let url = URL(string: url) else { throw HttpError.urlError }
            
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = sendData
        
            let (data, response) = try await urlSession.data(for: request)
                                
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                throw HttpError.statusCodeError
            }
            
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            Logger.error(error)
            return Response(result: .fail, message: error.localizedDescription, data: nil)
        }
    }
}
