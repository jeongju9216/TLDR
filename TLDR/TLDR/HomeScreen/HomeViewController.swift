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
        let text: String = inputText

        Task {
            //["코로나", "한중", "공급망", "협력", "강화에", "탄소중립", "교류를", "MOU"]
            let testDict: [String: String] = [
                "summarize" : testData.summarize,
                "text_keywords" : "코로나|한중|공급망|",
                "summarize_keywords" : "협력|강화에|탄소중립|",
                "language" : "auto"
            ]
            
//            let response = Response(result: .ok, message: "Test", data: testDict)
            let response = await HttpService.shard.postSummarize(text: text, language: .auto)
            
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
        guard let json = response.data else {
            throw HttpError.jsonError
        }

        Logger.info(json)

        let responseData: SummarizeResponseData = try SummarizeResponseData.decode(dictionary: json)
        
        let textKeywords: [String] = ["전체"] + responseData.textKeywords.components(separatedBy: "|").dropLast()
        let summarizeKeywords: [String] = ["전체"] + responseData.summarizeKeywords.components(separatedBy: "|").dropLast()

        let summarizeData = SummarizeData(text: text, summarizeText: responseData.summarize, textKeywords: textKeywords, summarizeKeywords: summarizeKeywords)

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
