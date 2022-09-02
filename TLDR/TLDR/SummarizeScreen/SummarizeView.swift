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
    
    //핵심 키워드
    private var keywordUnderLineLabel: UnderLineLabel!
    private var keywordLabel: UILabel!
    
    
    //MARK: - Properties
    private var fontSize: CGFloat = 18
    private var contentSize: CGFloat {
        let size = CGSize(width: self.bounds.width, height: .infinity)
        let estimatedSize = summarizeTextView.sizeThatFits(size)

        return min(estimatedSize.height, self.bounds.height * 0.3)
    }
    let testString = "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세"
    let testKeyword: [String] = ["동해물", "백두산", "하느님", "우리나라", "만세", "대한", "무궁화"]
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Setup
    private func setup() {
        setupSummarizeUnderLineLabel()
        setupSummarizeTextView()
        
        setupKeywordUnderLineLabel()
        setupKeywordLabel()
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
        
        summarizeTextView.applyTextWithLineHeight(string: testString)
        summarizeTextView.textColor = .label
        summarizeTextView.font = UIFont.systemFont(ofSize: fontSize)
        summarizeTextView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        
        self.addSubview(summarizeTextView)
        summarizeTextView.pinWidth(constant: self.bounds.width)
        summarizeTextView.pinHeight(constant: contentSize)
        summarizeTextView.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor)
        summarizeTextView.pinRight(to: self.safeAreaLayoutGuide.rightAnchor)
        summarizeTextView.pinTop(to: self.summarizeUnderLineLabel.bottomAnchor, offset: 10)
    }
    
    private func setupKeywordUnderLineLabel() {
        keywordUnderLineLabel = UnderLineLabel(title: "핵심 키워드")
        
        self.addSubview(keywordUnderLineLabel)
        keywordUnderLineLabel.pinHeight(constant: 30)
        keywordUnderLineLabel.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor, offset: 15)
        keywordUnderLineLabel.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -15)
        keywordUnderLineLabel.pinTop(to: self.summarizeTextView.bottomAnchor, offset: 30)
    }
    
    private func setupKeywordLabel() {
        keywordLabel = UILabel()
        
        var str: String = ""
        for keyword in testKeyword {
            str += "#\(keyword) "
        }
        
        keywordLabel.text = str
        keywordLabel.font = UIFont.systemFont(ofSize: fontSize)
        keywordLabel.lineBreakMode = .byCharWrapping
        keywordLabel.numberOfLines = .zero
        
        self.addSubview(keywordLabel)
        keywordLabel.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor, offset: 20)
        keywordLabel.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -20)
        keywordLabel.pinTop(to: self.keywordUnderLineLabel.bottomAnchor, offset: 15)
        
    }
}
