//
//  BaseViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

class BaseViewController<LayoutView: UIView>: UIViewController, Alertable, Loggable {
    //MARK: - Views
    var layoutView: LayoutView {
        return view as! LayoutView
    }
    
    private let errorMessage = "에러가 발생했습니다.\n다시 시도해 주세요."
    
    //MARK: - Life Cycles
    override func loadView() {
        self.view = LayoutView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .backgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Methods
    func showErrorAlert(message: String? = nil, action: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            let errorAlert = UIAlertController(title: nil,
                                               message: "",
                                               preferredStyle: .alert)
            
            let message = message ?? self.errorMessage
            errorAlert.message = message
            
            let doneAction = UIAlertAction(title: "확인",
                                           style: .default,
                                           handler: action)
            errorAlert.addAction(doneAction)
            
            self.present(errorAlert, animated: true)
        }
    }
}
