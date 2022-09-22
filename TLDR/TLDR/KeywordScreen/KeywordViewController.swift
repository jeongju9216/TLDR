//
//  KeywordViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/02.
//

import UIKit

final class KeywordViewController: BaseViewController<KeywordView> {
    
    //MARK: - Properties
    var summarizeData: SummarizeData?
    private var selectedKeywords: Set<String> = []
    
    private var keywordViewModel: KeywordViewModel = KeywordViewModel()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        guard let summarizeData = summarizeData else {
            return
        }
        
        self.layoutView.setup()
        
        bind()
        
        self.layoutView.setText(summarizeData.text)
        self.layoutView.setKeywords(summarizeData.keywords)
        
        self.keywordViewModel.setKeywords(summarizeData.keywords)
    }
    
    //MARK: - Methods
    private func bind() {
        keywordViewModel.keywords.bind { [weak self] selectedKeywords in
            print("\(#line)-line, \(#function): \(selectedKeywords)")
            self?.layoutView.highlightKeywords(selectedKeywords)
        }
    }
}
