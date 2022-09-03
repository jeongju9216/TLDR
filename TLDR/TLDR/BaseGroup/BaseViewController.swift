//
//  BaseViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

class BaseViewController<LayoutView: UIView>: UIViewController {
    var layoutView: LayoutView {
        return view as! LayoutView
    }
    
    //MARK: - Life Cycles
    override func loadView() {
        self.view = LayoutView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .backgroundColor
    }
    
    //MARK: - Methods
    func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .label
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundColor
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
}
