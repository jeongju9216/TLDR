//
//  LauchViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit
import JeongLogger

final class LaunchViewController: BaseViewController<LaunchView> {
    
    //MARK: - Properties
    private var launchVM: LaunchViewModel = LaunchViewModel()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        launchVM.launch()
    }
    
    //MARK: - Methods
    private func bind() {
        launchVM.stateData.bind { [weak self] stateData in
            guard let self = self,
                  let stateData = stateData else {
                return
            }
            
            guard stateData.state == .ok else {
                self.showErrorAlert(message: stateData.notice) { _ in
                    exit(0)
                }

                return
            }
            
            self.goHomeVC()
        }
    }
    
    private func goHomeVC() {
        Task {
            do {
                try await Task.sleep(nanoseconds: TimeUtil.nano2sec(0.5)) //런치 시간
            } catch {
            }
            
            let navigationVC: UINavigationController = UINavigationController(rootViewController: HomeViewController())
            navigationVC.modalPresentationStyle = .fullScreen
            
            self.dismiss(animated: false)
            self.present(navigationVC, animated: false)
        }
    }
}
