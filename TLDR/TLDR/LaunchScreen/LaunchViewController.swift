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
        
        Task {
            let versionResponse = await HttpService.shard.getVersion()
            if versionResponse.result == .ok, let versionData = versionResponse.data {
                setVersion(versionData)
            }
            
            try await Task.sleep(nanoseconds: TimeUtil.nano2sec(0.5)) //런치 시간
                    
            let navigationVC: UINavigationController = UINavigationController(rootViewController: HomeViewController())
            navigationVC.modalPresentationStyle = .fullScreen
            self.present(navigationVC, animated: false)
        }
    }
    
    private func setVersion(_ data: String) {
        BaseData.shared.currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
    }
    
    private func postVersion() async {
        let forced: String = "1.0.0"
        let lasted: String = "1.0.0"
        
        let result = await HttpService.shard.postVersion(forced: forced, lasted: lasted)
        print(result)
    }
}
