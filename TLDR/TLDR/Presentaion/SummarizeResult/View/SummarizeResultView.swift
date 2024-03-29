//
//  SummarizeResultView.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import UIKit

final class SummarizeResultView: UIView {
    
    //MARK: - Views
    private var topBarView: TopBarView!
    var backButton: UIButton!
    
    //핵심 키워드
    var keywordCollectionView: UICollectionView!
    
    private var titleUnderLineLabel: UnderLineLabel! //타이틀
    private var textView: UITextView! //요약내용 TextView
    
    var textModeButton: UIButton!
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Methods
    func setText(_ text: String) {
        textView.text = text
    }
    
    func highlightKeywords(_ keywords: Set<String>) {
        textView.highlightKeywords(keywords)
    }
    
    func showSummarizeResult() {
        titleUnderLineLabel.changeTitle("요약 내용")
        textModeButton.setTitle("원본 보기", for: .normal)
    }
    
    func showOriginalText() {
        titleUnderLineLabel.changeTitle("원본 내용")
        textModeButton.setTitle("요약 보기", for: .normal)
    }
    
    func reloadCollectionView() {
        keywordCollectionView.reloadData()
        keywordCollectionView.selectItem(at: IndexPath(row: 0, section: 0),
                                         animated: false,
                                         scrollPosition: .init())
    }
    
    //MARK: - Setup
    func setup() {
        setupTopBarView()
        setupBackButton()
        
        setupKeywordCollectionView()
        
        setupTitleUnderLineLabel()
        setupTextModeButton()
        setupSummarizeTextView()
    }
    
    private func setupTopBarView() {
        topBarView = TopBarView(frame: .zero)
        
        self.addSubview(topBarView)
        topBarView.pinHeight(constant: topBarView.height)
        topBarView.pinLeft(to: self.leftAnchor)
        topBarView.pinRight(to: self.rightAnchor)
        topBarView.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
    }
    
    private func setupBackButton() {
        backButton = UIButton(type: .custom)
        
        backButton.setImage(.init(systemName: "chevron.backward",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 21, weight: .medium)),
                            for: .normal)
        backButton.tintColor = .label
        backButton.imageView?.contentMode = .scaleAspectFit
        
        self.addSubview(backButton)
        backButton.pinBottom(to: topBarView.bottomAnchor, offset: -10)
        backButton.pinLeft(to: topBarView.leftAnchor, offset: 10)
    }
    
    private func setupKeywordCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        keywordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        keywordCollectionView.backgroundColor = .backgroundColor
        keywordCollectionView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        keywordCollectionView.showsHorizontalScrollIndicator = false
        keywordCollectionView.allowsMultipleSelection = true
        
        self.addSubview(keywordCollectionView)
        keywordCollectionView.pinHeight(constant: 60)
        keywordCollectionView.pinLeft(to: self.leftAnchor)
        keywordCollectionView.pinRight(to: self.rightAnchor)
        keywordCollectionView.pinTop(to: self.topBarView.bottomAnchor, offset: 5)
    }

    private func setupTitleUnderLineLabel() {
        titleUnderLineLabel = UnderLineLabel(title: "요약 내용")
        
        self.addSubview(titleUnderLineLabel)
        titleUnderLineLabel.pinHeight(constant: 30)
        titleUnderLineLabel.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor, offset: 15)
        titleUnderLineLabel.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -15)
        titleUnderLineLabel.pinTop(to: self.keywordCollectionView.bottomAnchor, offset: 5)
    }
    
    private func setupTextModeButton() {
        textModeButton = UIButton(type: .custom)
        
        textModeButton.setTitleColor(.label, for: .normal)
        textModeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        textModeButton.alpha = 0.8
        
        self.addSubview(textModeButton)
        textModeButton.pinTop(to: self.titleUnderLineLabel.topAnchor)
        textModeButton.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -15)
    }
    
    private func setupSummarizeTextView() {
        textView = UITextView()
        
        textView.isEditable = false
        textView.backgroundColor = .backgroundColor
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        textView.applyLineHeight()
        
        self.addSubview(textView)
        textView.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor)
        textView.pinRight(to: self.safeAreaLayoutGuide.rightAnchor)
        textView.pinTop(to: self.titleUnderLineLabel.bottomAnchor, offset: 10)
        textView.pinBottom(to: self.bottomAnchor)
    }
}
