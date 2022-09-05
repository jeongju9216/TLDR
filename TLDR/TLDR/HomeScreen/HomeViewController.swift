//
//  HomeViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    
    //MARK: - Properties
    private var inputText: String = "" //입력한 글자
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationController?.navigationBar.isHidden = true //커스텀 네비게이션 사용함
        
        addTargets()
        addObservers()
        addDelegate()
    }
    
    //MARK: - Actions
    @objc func clickedSumUpButton() {
        print("\(#line)-line, \(#function)")
        
        //todo
        //서버에서 결과 받아오기
        
        let summarizeVC: SummarizeViewController = SummarizeViewController()
        //todo
        //결과값으로 전달함
        summarizeVC.summarizeData = testData()
        self.navigationController?.pushViewController(summarizeVC, animated: true)
    }
    
    @objc func clickedHideKeyboardButton() {
        print("\(#line)-line, \(#function)")
        self.layoutView.showTopBar()
        self.layoutView.showSummarizeButton()
        
        self.layoutView.textView.endEditing(true)
    }
    
    //키보드 보였을 때
    @objc func keyboardWillShow(notification: NSNotification) {
        print("\(#line)-line, \(#function)")
        self.layoutView.hideTopBar()
        self.layoutView.hideSummarizeButton()
    }
    
    //MARK: - Methods
    private func testData() -> SummarizeData {
        return SummarizeData(text: BaseData.shared.testText, summarizeText: BaseData.shared.testSummarizeText, keywords: BaseData.shared.testKeywords)
    }
    
    private func addTargets() {
        self.layoutView.summarizeButton.addTarget(self, action: #selector(clickedSumUpButton), for: .touchUpInside)
        self.layoutView.hideKeyboardButton.addTarget(self, action: #selector(clickedHideKeyboardButton), for: .touchUpInside)
    }
    
    private func addDelegate() {
        self.layoutView.textView.delegate = self
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
    }
}

extension HomeViewController: UITextViewDelegate {
    //입력이 완료되었을 때 값 넣기
    func textViewDidEndEditing(_ textView: UITextView) {
        self.inputText = textView.text
    }
}
