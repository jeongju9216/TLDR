//
//  HomeViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layoutView.sumUpButton.addTarget(self, action: #selector(clickedSumUpButton), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc func clickedSumUpButton() {
        print("\(#line)-line, \(#function)")
    }
}
