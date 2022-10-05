//
//  HomeViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    //todo
    //입력값 없으면 요약하기 버튼 비활성화
    
    //MARK: - Properties
    private var inputText: String = "" //입력한 글자
    
    private var homeVM: HomeViewModel = HomeViewModel()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationController?.navigationBar.isHidden = true //커스텀 네비게이션 사용함
        
        addTargets()
        addObservers()
        addDelegate()
    }
    
    //MARK: - Actions
    @objc private func clickedSumUpButton() {
        let testData = TestData()
        let text: String = inputText
        
        guard !text.isEmpty else {
            self.showErroAlert(message: "요약할 내용이 없습니다.")
            return
        }

        Task {
            let response = await homeVM.postSummarize(text: text, language: .auto)
            
            do {
                guard response.result == .ok else {
                    throw HttpError.summarizeError(message: response.message)
                }
                
                let summarizeData = try homeVM.parsingSummarizeData(response, text: text)
                
                goSummarizeVC(summarizeData)
            } catch HttpError.summarizeError(let message) {
                Logger.error("error message: \(message)")
                self.showErroAlert(message: message)
            } catch {
                Logger.error(error.localizedDescription)
                self.showErroAlert()
            }
        }
    }
    
    @objc private func clickedHideKeyboardButton() {
        self.layoutView.showTopBar()
        self.layoutView.showSummarizeButton()
        
        self.layoutView.textView.endEditing(true)
    }
    
    //키보드 보였을 때
    @objc func keyboardWillShow(notification: NSNotification) {
        self.layoutView.hideTopBar()
        self.layoutView.hideSummarizeButton()
    }
    
    //MARK: - Methods
    private func goSummarizeVC(_ summarizeData: SummarizeData) {
        DispatchQueue.main.async {
            let summarizeVC: SummarizeViewController = SummarizeViewController()
            
            summarizeVC.summarizeData = summarizeData
            
            self.navigationController?.pushViewController(summarizeVC, animated: true)
        }
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
