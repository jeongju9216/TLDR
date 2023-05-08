//
//  Alertable.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/08.
//

import UIKit

protocol Alertable {
    func showAlert(title: String?, message: String, action: ((UIAlertAction) -> Void)?)
    func showCancelAlert(title: String?, message: String, doneAction: ((UIAlertAction) -> Void)?, cancelAction: ((UIAlertAction) -> Void)?)
}

extension Alertable where Self: UIViewController {
    func showAlert(title: String? = "알림", message: String = "", action: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            let alert = UIAlertController(title: title,
                                               message: message,
                                               preferredStyle: .alert)
                        
            let doneAction = UIAlertAction(title: "확인",
                                           style: .default,
                                           handler: action)
            alert.addAction(doneAction)
            
            self.present(alert, animated: true)
        }
    }
    
    func showCancelAlert(title: String? = "알림", message: String = "", doneAction: ((UIAlertAction) -> Void)? = nil, cancelAction: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            let alert = UIAlertController(title: title,
                                               message: message,
                                               preferredStyle: .alert)
                        
            let doneAction = UIAlertAction(title: "확인",
                                           style: .default,
                                           handler: doneAction)
            
            let cancelAction = UIAlertAction(title: "취소",
                                             style: .cancel,
                                           handler: cancelAction)
            alert.addAction(doneAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
    }
}
