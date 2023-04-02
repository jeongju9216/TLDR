//
//  LaunchViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/10/05.
//

import Foundation

struct LaunchViewModel {
    
    //MARK: - Properties
    let stateData: Observable<StateData?> = Observable(nil)
    
    //MARK: - Methods
    func launch() {
        Task {
            let serverStateData: StateData = await getServerStateData()
            
            let versionData: VersionData = await getVersionData()
            setVersion(versionData)
            
            await setPolicyURL()
            
            stateData.value = serverStateData
        }
    }
    
    func getServerStateData() async -> StateData {
        return await FirebaseService.shared.fetchState()
    }
    
    func getVersionData() async -> VersionData {
        return await FirebaseService.shared.fetchVersion()
    }
    
    func setVersion(_ version: VersionData) {        
        BaseData.shared.currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
        BaseData.shared.forcedUpdateVersion = version.forced
        BaseData.shared.lastetVersion = version.lasted
        
        BaseData.shared.appleID = version.appleID
        BaseData.shared.bundleID = version.bundleID
    }
    
    func setPolicyURL() async {
        BaseData.shared.policyURL = await FirebaseService.shared.fetchPolicyURL()
    }
}
