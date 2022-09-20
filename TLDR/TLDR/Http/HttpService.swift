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
    let data: String?
}

final class HttpService {
    static let shard: HttpService = HttpService()
    private init() { }

    private let domain: String = "https://www.tldr161718.site/"
    
    //GET
    func getVersion() async -> Response {
        let response = await requestGet(url: self.domain + HttpAPI.version.rawValue)
        return response
    }
    
    func getStatus() async -> Response {
        let response = await requestGet(url: self.domain + HttpAPI.state.rawValue)
        return response
    }
    
    //POST
    func postVersion(forced: String, lasted: String) async -> Response {
        let param = ["forced": forced, "lasted": lasted]
        let response = await requestPost(url: self.domain + HttpAPI.version.rawValue, param: param)
        return response
    }
    
    func postState(state: String, notice: String) async -> Response {
        let param = ["state": state, "notice": notice]
        let response = await requestPost(url: self.domain + HttpAPI.state.rawValue, param: param)
        return response
    }
    
    func postSummarize(text: String, language: SummarizeLangauge) async -> Response {
        let param = ["text": text, "language": language.rawValue]
        let response = await requestPost(url: self.domain + HttpAPI.summarize.rawValue, param: param)
        return response
    }
}

extension HttpService {
    private func requestGet(url: String) async -> Response {
        do {
            guard let url = URL(string: url) else { throw HttpError.urlError }
            
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                throw HttpError.statusCodeError
            }
            
            let output: Response = try JSONDecoder().decode(Response.self, from: data)
            return output
        } catch {
            return Response(result: .fail, message: error.localizedDescription, data: nil)
        }
    }
    
    private func requestPost(url: String, param: [String: Any]) async -> Response {
        do {
            guard let sendData = try? JSONSerialization.data(withJSONObject: param, options: [.prettyPrinted]) else { throw HttpError.jsonError }
            
            guard let url = URL(string: url) else { throw HttpError.urlError }
            
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = sendData
        
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                throw HttpError.statusCodeError
            }
            
            let output: Response = try JSONDecoder().decode(Response.self, from: data)
            return output
        } catch {
            return Response(result: .fail, message: error.localizedDescription, data: nil)
        }
    }
}
