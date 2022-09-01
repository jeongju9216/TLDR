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
            try await Task.sleep(nanoseconds: TimeUtil.nano2sec(0.5)) //런치 시간
                    
            let navigationVC: UINavigationController = UINavigationController(rootViewController: HomeViewController())
            navigationVC.modalPresentationStyle = .fullScreen
            self.present(navigationVC, animated: false)
        }
    }
}
