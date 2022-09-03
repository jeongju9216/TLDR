//
//  SummarizeView.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import Foundation
import UIKit

final class SummarizeView: UIView {
    
    //MARK: - Views
    //요약 내용
    private var summarizeUnderLineLabel: UnderLineLabel!
    private var summarizeTextView: UITextView!
    var keywordButton: UIButton!
    
    private var summarizeText: String = ""
    private var countOfKeywords: Int = 0
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Setup
    func setup(summarizeText: String, countOfKeywords: Int) {
        self.summarizeText = summarizeText
        self.countOfKeywords = countOfKeywords
        
        setupSummarizeUnderLineLabel()
        setupKeywordButton()

        setupSummarizeTextView()
    }
    
    private func setupSummarizeUnderLineLabel() {
        summarizeUnderLineLabel = UnderLineLabel(title: "요약 내용")
        
        self.addSubview(summarizeUnderLineLabel)
        summarizeUnderLineLabel.pinHeight(constant: 30)
        summarizeUnderLineLabel.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor, offset: 15)
        summarizeUnderLineLabel.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -15)
        summarizeUnderLineLabel.pinTop(to: self.safeAreaLayoutGuide.topAnchor, offset: 15)
    }
    
    private func setupSummarizeTextView() {
        summarizeTextView = UITextView()
        
        summarizeTextView.isEditable = false
        summarizeTextView.backgroundColor = .backgroundColor
        summarizeTextView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        summarizeTextView.text = summarizeText
        summarizeTextView.applyLineHeight()
        
        self.addSubview(summarizeTextView)
        summarizeTextView.pinWidth(constant: self.bounds.width)
        summarizeTextView.pinTop(to: self.summarizeUnderLineLabel.bottomAnchor, offset: 10)
        summarizeTextView.pinBottom(to: self.keywordButton.topAnchor, offset: -10)
    }
    
    private func setupKeywordButton() {
        keywordButton = UIButton(type: .custom)
        
        keywordButton.setBackgroundColor(.mainColor, for: .normal)
        
        keywordButton.setTitle("\(countOfKeywords)개 키워드로 원본 보기", for: .normal)
        keywordButton.setTitleColor(.white, for: .normal)
        keywordButton.setTitleColor(.lightGray, for: .highlighted)
        
        keywordButton.titleLabel?.textAlignment = .center
        keywordButton.titleLabel?.font = .boldSystemFont(ofSize: 21)
        
        self.addSubview(keywordButton)
        keywordButton.pinWidth(constant: self.bounds.width)
        keywordButton.pinHeight(constant: 80)
        keywordButton.pinBottom(to: self.bottomAnchor)
    }
}
