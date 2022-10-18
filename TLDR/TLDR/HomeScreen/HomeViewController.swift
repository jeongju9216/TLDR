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
    private var homeVM: HomeViewModel = HomeViewModel()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
             
        addTargets()
        addObservers()
        addDelegate()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true //커스텀 네비게이션 사용함
    }
    
    //MARK: - Methods
    private func bind() {
        homeVM.text.bind { [weak self] text in
            guard let self = self else {
                return
            }
            
            self.layoutView.setText(text)
            self.layoutView.setEnabled(!text.isEmpty)
        }
    }
    
    //MARK: - Actions
    @objc private func clickedSumUpButton() {
        let testData = TestData()

        Task {
            let response = await homeVM.postSummarize(language: .auto)
            
            do {
                guard response.result == .ok else {
                    throw HttpError.summarizeError(message: response.message)
                }
                
                let summarizeData = try homeVM.parsingSummarizeData(response)
                
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
    
    @objc private func clickedPasteButton() {
        if let pasteString = UIPasteboard.general.string {
            homeVM.updateText(homeVM.text.value + pasteString)
        }
    }
    
    @objc private func clickedResetButton() {
        homeVM.resetText()
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
        self.layoutView.pasteButton.addTarget(self, action: #selector(clickedPasteButton), for: .touchUpInside)
        self.layoutView.resetButton.addTarget(self, action: #selector(clickedResetButton), for: .touchUpInside)
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
        self.homeVM.updateText(textView.text)
    }
}
