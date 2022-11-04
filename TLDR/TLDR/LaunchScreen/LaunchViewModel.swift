//
//  LaunchViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/10/05.
//

import Foundation

struct LaunchViewModel {
    
    func checkState() async throws {
        let response = await getServerState()
        guard response.result == .ok else {
            throw HttpError.apiError
        }
        
        let data = try parsingStateData(response)
        guard data.state == .ok else {
            throw HttpError.serverStateError(notice: data.notice)
        }
    }

    func checkVersion() async throws {
        let response = await getVersionInfo()
        guard response.result == .ok else {
            throw HttpError.apiError
        }
        
        let data = try parsingVersionData(response)
        setVersion(data)
    }
    
    func getServerState() async -> Response {
        return await HttpService.shard.getState()
    }
    
    func getVersionInfo() async -> Response {
        return await HttpService.shard.getVersion()
    }
    
    func parsingStateData(_ response: Response) throws -> StateData {
        Logger.debug(response.data)

        guard let json = response.data else {
            throw HttpError.jsonError
        }
        
        return try StateData.decode(dictionary: json)
    }
    
    func parsingVersionData(_ response: Response) throws -> VersionData {
        Logger.debug(response.data)

        guard let json = response.data else {
            throw HttpError.jsonError
        }
        
        return try VersionData.decode(dictionary: json)
    }
    
    func setVersion(_ version: VersionData) {
        Logger.info(version)
        
        BaseData.shared.currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
        BaseData.shared.forcedUpdateVersion = version.forced
        BaseData.shared.lastetVersion = version.lasted
        
        BaseData.shared.appleID = version.appleID
        BaseData.shared.bundleID = version.bundleID
    }
}
