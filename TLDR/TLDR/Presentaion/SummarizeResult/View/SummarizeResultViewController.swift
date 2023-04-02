//
//  SummarizeResultViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import UIKit

final class SummarizeResultViewController: BaseViewController<SummarizeResultView> {
    
    //MARK: - Properties
    private var keywordVM: KeywordViewModel = KeywordViewModel()
    private let summarizeResult: SummarizeResult
    private var isShowSummarizeResult = true
    
    //MARK: - Life Cycles
    init(summarizeResult: SummarizeResult) {
        self.summarizeResult = summarizeResult
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupCollectionView()
        
        addTargets()
        
        bind()
        
        updateData()
    }
    
    //MARK: - Actions
    @objc private func clickedTextModeButton() {
        isShowSummarizeResult.toggle()
        updateData()
    }
    
    @objc private func clickedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    private func bind() {
        keywordVM.keywords.bind { [weak self] totalKeywords in
            guard let self = self else {
                return
            }
            
            self.layoutView.reloadCollectionView()
        }
        
        keywordVM.selectedKeywords.bind { [weak self] selectedKeywords in
            guard let self = self else {
                return
            }
            
            self.layoutView.highlightKeywords(selectedKeywords.keywords)
        }
    }
    
    private func updateData() {
        keywordVM.deselectAll()
        
        let currentText = isShowSummarizeResult ? summarizeResult.summarizeText
                                                : summarizeResult.text
        let currentKeywords = isShowSummarizeResult ? summarizeResult.summarizeKeywords
                                                    : summarizeResult.textKeywords
        
        layoutView.setText(currentText)
        keywordVM.updateTotalKeywords(currentKeywords)
        
        if isShowSummarizeResult {
            layoutView.showSummarizeResult()
        } else {
            layoutView.showOriginalText()
        }
        
        keywordVM.selectAll()
    }
    
    //MARK: - Setup
    private func setupCollectionView() {
        self.layoutView.keywordCollectionView.register(KeywordCell.classForCoder(), forCellWithReuseIdentifier: KeywordCell.id)
        self.layoutView.keywordCollectionView.delegate = self
        self.layoutView.keywordCollectionView.dataSource = self
    }
    
        
    private func addTargets() {
        self.layoutView.textModeButton.addTarget(self,
                                                 action: #selector(clickedTextModeButton),
                                                 for: .touchUpInside)
        self.layoutView.backButton.addTarget(self,
                                                 action: #selector(clickedBackButton),
                                                 for: .touchUpInside)
    }
}

extension SummarizeResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordVM.getTotalKeywordsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.layoutView.keywordCollectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.id, for: indexPath) as! KeywordCell
        
        cell.setKeyword(keywordVM.getTotalKeywords()[indexPath.row])
        
        return cell
    }
}

extension SummarizeResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.keywordVM.selectAll()
            for i in 1..<keywordVM.getTotalKeywordsCount() {
                layoutView.keywordCollectionView.deselectItem(at: IndexPath(row: i, section: 0),
                                                              animated: false)
            }
        } else {
            log(.debug, self.keywordVM.getPrevSelectedIndex())
            if self.keywordVM.getPrevSelectedIndex() == 0 {
                self.keywordVM.deselectAll()
                layoutView.keywordCollectionView.deselectItem(at: IndexPath(row: 0, section: 0),
                                                              animated: false)
            }
            
            self.keywordVM.selected(index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.keywordVM.deselectAll()
        } else {
            self.keywordVM.deselected(index: indexPath.row)
        }
    }
}

extension SummarizeResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = UILabel()
        label.text = keywordVM.getKeyword(index: indexPath.row)
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        
        let size = label.frame.size
        return CGSize(width: size.width + 40, height: size.height + 16)
    }
}
