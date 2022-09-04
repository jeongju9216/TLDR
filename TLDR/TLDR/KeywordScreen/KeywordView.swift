//
//  KeywordView.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/02.
//

import UIKit

final class KeywordView: UIView {
    
    //MARK: - Views
    //핵심 키워드
    private var keywordUnderLineLabel: UnderLineLabel!
    private var keywordLabel: UILabel!

    //키워드 강조 원본
    private var textUnderLineLabel: UnderLineLabel!
    private var textView: UITextView!
        
    //MARK: - Properties
    private var keywords: [String] = []
    private var text: String = ""
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Setup
    func setup(keywords: [String], text: String) {
        self.keywords = keywords
        self.text = text
        
        setup()
    }
    
    private func setup() {
        setupKeywordUnderLineLabel()
        setupKeywordLabel()
        
        setupTextUnderLineLabel()
        setupTextView()
    }
    
    private func setupKeywordUnderLineLabel() {
        keywordUnderLineLabel = UnderLineLabel(title: "핵심 키워드")
        
        self.addSubview(keywordUnderLineLabel)
        keywordUnderLineLabel.pinHeight(constant: 30)
        keywordUnderLineLabel.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor, offset: 15)
        keywordUnderLineLabel.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -15)
        keywordUnderLineLabel.pinTop(to: self.safeAreaLayoutGuide.topAnchor, offset: 15)
    }
    
    private func setupKeywordLabel() {
        keywordLabel = UILabel()
        
        var str: String = ""
        keywords.forEach { str += "#\($0) " }
        
        keywordLabel.text = str
        keywordLabel.font = UIFont.systemFont(ofSize: TextUtil.fontSize)
        keywordLabel.lineBreakMode = .byCharWrapping
        keywordLabel.numberOfLines = .zero
        
        self.addSubview(keywordLabel)
        keywordLabel.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor, offset: 15)
        keywordLabel.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -15)
        keywordLabel.pinTop(to: self.keywordUnderLineLabel.bottomAnchor, offset: 15)
    }
    
    private func setupTextUnderLineLabel() {
        textUnderLineLabel = UnderLineLabel(title: "원본")
        
        self.addSubview(textUnderLineLabel)
        textUnderLineLabel.pinHeight(constant: 30)
        textUnderLineLabel.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor, offset: 15)
        textUnderLineLabel.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -15)
        textUnderLineLabel.pinTop(to: self.keywordLabel.bottomAnchor, offset: 20)
    }
    
    private func setupTextView() {
        textView = UITextView()
        
        textView.isEditable = false
        textView.backgroundColor = .backgroundColor
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 40, right: 10)
        
        textView.text = self.text
        textView.applyLineHeight()
        textView.highlightKeywords(keywords)
                
        self.addSubview(textView)
        textView.pinWidth(constant: self.bounds.width)
        textView.pinTop(to: self.textUnderLineLabel.bottomAnchor, offset: 10)
        textView.pinBottom(to: self.bottomAnchor)
    }
}
