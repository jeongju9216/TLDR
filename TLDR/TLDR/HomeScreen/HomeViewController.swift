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
    @objc private func clickedSumUpButton() {
        let testData = TestData()
        let text: String = testData.text//inputText
        
        Task {
            let testJson = "{\"summarize\":\"\(testData.summarize)\",\"keywords\":\"경제협력|양해각서|경제|교류|한중|중국|글로벌\",\"language\":\"ko\"}"
            let response = Response(result: .ok, message: "Test", data: testJson)//await HttpService.shard.postSummarize(text: text, language: .auto)
            
            do {
                guard response.result == .ok else { throw HttpError.apiError }
                
                let summarizeData = try parsingSummarizeData(response, text: text)
                
                goSummarizeVC(summarizeData)
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
    
    private func parsingSummarizeData(_ response: Response, text: String) throws -> SummarizeData {
        guard let json = response.data, let data = json.data(using: .utf8) else {
            throw HttpError.jsonError
        }
        
        Logger.info(json)
        
        let responseData = try JSONDecoder().decode(SummarizeResponseData.self, from: data)
        
        let keywords: [String] = ["전체"] + responseData.keywords.components(separatedBy: "|")
        
        let summarizeData = SummarizeData(text: text, summarizeText: responseData.summarize, keywords: keywords)
        
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
