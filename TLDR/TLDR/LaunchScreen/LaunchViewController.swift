//
//  LauchViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class LaunchViewController: BaseViewController<LaunchView> {
    
    //MARK: - Properties
    private var launchVM: LaunchViewModel = LaunchViewModel()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logger.debug("앱 시작")
        
        launch()
    }
    
    //MARK: - Methods
    private func launch() {
        Task {
            do {
                try await launchVM.checkState() //서버 State 체크
                try await launchVM.checkVersion() //버전 체크
                
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
