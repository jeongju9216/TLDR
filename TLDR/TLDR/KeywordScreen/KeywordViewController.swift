//
//  KeywordViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/02.
//

import UIKit

final class KeywordViewController: BaseViewController<KeywordView> {
    
    //MARK: - Properties
    var summarizeData: SummarizeData = SummarizeData()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        self.layoutView.setup(keywords: summarizeData.keywords, text: summarizeData.text)
    }
}
