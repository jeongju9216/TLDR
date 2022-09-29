//
//  BaseViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

class BaseViewController<LayoutView: UIView>: UIViewController {
    //MARK: - Views
    var layoutView: LayoutView {
        return view as! LayoutView
    }
    
    private let errorMessage = "에러가 발생했습니다.\n다시 시도해 주세요."
    lazy private var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "에러", message: "", preferredStyle: .alert)
        return alert
    }()
    
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
    
    func showErroAlert(message: String? = nil, action: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let message = message ?? self.errorMessage
            self.errorAlert.message = message
            
            let doneAction = UIAlertAction(title: "확인", style: .default, handler: action)
            self.errorAlert.addAction(doneAction)
            
            self.present(self.errorAlert, animated: true)
        }
    }
}
