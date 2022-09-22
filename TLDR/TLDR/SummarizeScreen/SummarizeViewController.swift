//
//  SummarizeViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import UIKit

final class SummarizeViewController: BaseViewController<SummarizeView> {
    
    //MARK: - Properties
    var summarizeData: SummarizeData = SummarizeData(text: "", summarizeText: "", keywords: [])
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupNavigationBar() //네비게이션 세팅
        self.layoutView.setup(summarizeText: summarizeData.summarizeText,
                              countOfKeywords: summarizeData.keywords.count)
        
        addTargets()        
    }
    
    //MARK: - Actions
    @objc func clickedKeywordButton() {
        print("\(#line)-line, \(#function)")
    
        let keywordVC: KeywordViewController = KeywordViewController()
        keywordVC.summarizeData = self.summarizeData //전달받은 데이터 그대로 넣기
        self.navigationController?.pushViewController(keywordVC, animated: true)
    }
    
    //MARK: - Methods
    private func addTargets() {
        self.layoutView.keywordButton.addTarget(self, action: #selector(clickedKeywordButton), for: .touchUpInside)
    }
}
