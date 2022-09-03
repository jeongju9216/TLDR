//
//  HomeViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    
    //MARK: - Properties
    private var inputText: String = ""
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationController?.navigationBar.isHidden = true
        
        addTargets()
        addObservers()
        
        self.layoutView.textView.delegate = self
    }
    
    //MARK: - Actions
    @objc func clickedSumUpButton() {
        print("\(#line)-line, \(#function)")
        
        let summarizeVC: SummarizeViewController = SummarizeViewController()
        summarizeVC.summarizeData = testData()
        self.navigationController?.pushViewController(summarizeVC, animated: true)
    }
    
    @objc func clickedHideKeyboardButton() {
        print("\(#line)-line, \(#function)")
        self.layoutView.showTopBar()
        self.layoutView.showSummarizeButton()
        
        self.layoutView.textView.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("\(#line)-line, \(#function)")
        self.layoutView.hideTopBar()
        self.layoutView.hideSummarizeButton()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("\(#line)-line, \(#function)")
    }
    
    //MARK: - Methods
    private func testData() -> SummarizeData {
        return SummarizeData(text: self.inputText, summarizeText: BaseData.shared.testSummarizeText, keywords: BaseData.shared.testKeywords)
    }
    
    private func addTargets() {
        self.layoutView.summarizeButton.addTarget(self, action: #selector(clickedSumUpButton), for: .touchUpInside)
        self.layoutView.hideKeyboardButton.addTarget(self, action: #selector(clickedHideKeyboardButton), for: .touchUpInside)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
}

extension HomeViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.inputText = textView.text
    }
}
