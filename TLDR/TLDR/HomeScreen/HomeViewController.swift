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
     
        addTargets()
        addObservers()
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
    
    //MARK: - Methods
    private func addTargets() {
        self.layoutView.sumUpButton.addTarget(self, action: #selector(clickedSumUpButton), for: .touchUpInside)
        self.layoutView.hideKeyboardButton.addTarget(self, action: #selector(clickedHideKeyboardButton), for: .touchUpInside)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
}
