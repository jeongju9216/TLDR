//
//  LauchViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class LaunchViewController: BaseViewController<LaunchView> {
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logger.debug("앱 시작")
        launch()
    }
    
    //MARK: - Methods
    private func launch() {
        Task {
            let testJson = "{\"forced\":\"0.0.1\", \"lasted\":\"0.0.1\", \"appleID\" : \"123456\", \"bundleID\" : \"com.jeong9216.TLDR\"}"
            let versionResponse = Response(result: .ok, message: "테스트", data: testJson)
            //let versionResponse = await HttpService.shard.getVersion()
            
            do {
                guard versionResponse.result == .ok else {
                    throw HttpError.apiError
                }
                
                let versionData = try parsingVersionData(versionResponse)
                setVersion(versionData)
                
                try await Task.sleep(nanoseconds: TimeUtil.nano2sec(0.5)) //런치 시간
                
                goHomeVC()
            } catch {
                Logger.error(error.localizedDescription)
                self.showErroAlert(action: {_ in
                    exit(0)
                })
            }
        }
    }
    
    private func parsingVersionData(_ response: Response) throws -> VersionData {
        Logger.debug(response.data)

        guard let json = response.data, let data = json.data(using: .utf8) else {
            throw HttpError.jsonError
        }

        let versionData = try JSONDecoder().decode(VersionData.self, from: data)
        return versionData
    }
    
    private func setVersion(_ version: VersionData) {
        Logger.info(version)
        
        BaseData.shared.currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
        BaseData.shared.forcedUpdateVersion = version.forced
        BaseData.shared.lastetVersion = version.lasted
        
        BaseData.shared.appleID = version.appleID
        BaseData.shared.bundleID = version.bundleID
    }
    
    private func goHomeVC() {
        let navigationVC: UINavigationController = UINavigationController(rootViewController: HomeViewController())
        navigationVC.modalPresentationStyle = .fullScreen
        
        self.present(navigationVC, animated: false)
    }
}
