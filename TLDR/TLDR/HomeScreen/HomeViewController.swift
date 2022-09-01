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
        self.layoutView.hideKeyboardButton.addTarget(self, action: #selector(clickedHideKeyboardButton), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    //MARK: - Actions
    @objc func clickedSumUpButton() {
        print("\(#line)-line, \(#function)")
    }
    
    @objc func clickedHideKeyboardButton() {
        print("\(#line)-line, \(#function)")
        self.layoutView.showTopBar()
        self.layoutView.showSumUpButton()
        
        self.layoutView.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("\(#line)-line, \(#function)")
        self.layoutView.hideTopBar()
        self.layoutView.hideSumUpButton()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("\(#line)-line, \(#function)")
        
    }
}
