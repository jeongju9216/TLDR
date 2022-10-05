//
//  LauchViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class LaunchViewController: BaseViewController<LaunchView> {
    
    //MARK: - Properties
    private var launchViewModel: LaunchViewModel = LaunchViewModel()
    
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
//            let versionResponse = Response(result: .ok, message: "테스트", data: testJson)
            let stateResponse = await launchViewModel.getServerState()
            let versionResponse = await launchViewModel.getVersionInfo()
            
            do {
                guard versionResponse.result == .ok, stateResponse.result == .ok else {
                    throw HttpError.apiError
                }
                
                let stateData = try launchViewModel.parsingStateData(stateResponse)
                guard stateData.state == .ok else {
                    throw HttpError.serverStateError(notice: stateData.notice)
                }
                
                let versionData = try launchViewModel.parsingVersionData(versionResponse)
                launchViewModel.setVersion(versionData)
                
                try await Task.sleep(nanoseconds: TimeUtil.nano2sec(0.5)) //런치 시간
                
                goHomeVC()
            } catch HttpError.serverStateError(let notice) {
                Logger.error(notice)
                self.showErroAlert(message: notice, action: { _ in
                    exit(0)
                })
            } catch {
                Logger.error("\(error) / \(error.localizedDescription)")
                self.showErroAlert(action: { _ in
                    exit(0)
                })
            }
        }
    }
    
    private func goHomeVC() {
        let navigationVC: UINavigationController = UINavigationController(rootViewController: HomeViewController())
        navigationVC.modalPresentationStyle = .fullScreen
        
        self.present(navigationVC, animated: false)
    }
}
