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
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationController?.navigationBar.isHidden = true //커스텀 네비게이션 사용함
        
        addTargets()
        addObservers()
        addDelegate()
    }
    
    //MARK: - Actions
    @objc func clickedSumUpButton() async {
        let testData = TestData()
        
        let text: String = testData.text//inputText
        let response = await HttpService.shard.postSummarize(text: text, language: .auto)
        
        do {
            guard response.result == .ok else {
                throw HttpError.apiError
            }
            
            let summarizeData = try parsingSummarizeData(response, text: text)
            
            let summarizeVC: SummarizeViewController = SummarizeViewController()
            
            summarizeVC.summarizeData = summarizeData
            
            self.navigationController?.pushViewController(summarizeVC, animated: true)
        } catch {
            self.showErroAlert()
        }
    }
    
    @objc func clickedHideKeyboardButton() {
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
    private func parsingSummarizeData(_ response: Response, text: String) throws -> SummarizeData {
        guard let json = response.data, let data = json.data(using: .utf8) else {
            throw HttpError.jsonError
        }
        
        let responseData = try JSONDecoder().decode(SummarizeResponseData.self, from: data)
        let summarizeData = SummarizeData(text: text, summarizeText: responseData.summarize, keywords: Set(responseData.keywords))
        
        return summarizeData
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
