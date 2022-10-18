//
//  SummarizeViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import UIKit

final class SummarizeViewController: BaseViewController<SummarizeView> {
    
    //MARK: - Properties
    var summarizeData: SummarizeData = SummarizeData()
    
    private var keywordVM: KeywordViewModel = KeywordViewModel()
    private var textModeVM: TextModeViewModel = TextModeViewModel()

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        setupNavigationBar() //네비게이션 세팅
        
        self.layoutView.setup()
        setupCollectionView()
        self.layoutView.setText(summarizeData.summarizeText)
                
        addTargets()
        
        bind()
    }
    
    //MARK: - Actions
    @objc private func clickedTextModeButton() {
        textModeVM.toggleTextMode()
    }
    
    //MARK: - Methods
    private func bind() {
        keywordVM.keywords.bind { [weak self] totalKeywords in
            guard let self = self else {
                return
            }
            
            Logger.debug(totalKeywords)
            self.layoutView.keywordCollectionView.reloadData()
            self.layoutView.keywordCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .init())
        }
        
        keywordVM.selectedKeywords.bind { [weak self] selectedKeywords in
            guard let self = self else {
                return
            }
            
            Logger.debug(selectedKeywords)
            self.layoutView.highlightKeywords(selectedKeywords.keywords)
        }
        
        textModeVM.textMode.bind { [weak self] textMode in
            guard let self = self else { return }
            Logger.info(textMode)
            
            self.keywordVM.deselectAll()
            
            switch textMode {
            case .original:
                self.layoutView.setText(self.summarizeData.text)
                self.keywordVM.updateTotalKeywords(self.summarizeData.textKeywords)
            case .summarize:
                self.layoutView.setText(self.summarizeData.summarizeText)
                self.keywordVM.updateTotalKeywords(self.summarizeData.summarizeKeywords)
            }
            
            self.keywordVM.selectAll()
            self.layoutView.setTextModeLayout(textMode)
        }
    }
    
    //MARK: - Setup
    private func setupCollectionView() {
        self.layoutView.keywordCollectionView.register(KeywordCell.classForCoder(), forCellWithReuseIdentifier: "keywordCellIdentifier")
        self.layoutView.keywordCollectionView.delegate = self
        self.layoutView.keywordCollectionView.dataSource = self
    }
    
        
    private func addTargets() {
        self.layoutView.textModeButton.addTarget(self, action: #selector(clickedTextModeButton), for: .touchUpInside)
    }
}

extension SummarizeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordVM.getTotalKeywordsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.layoutView.keywordCollectionView.dequeueReusableCell(withReuseIdentifier: "keywordCellIdentifier", for: indexPath) as! KeywordCell
        
        cell.setKeyword(keywordVM.getTotalKeywords()[indexPath.row])
        
        return cell
    }
}

extension SummarizeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.keywordVM.selectAll()
            for i in 1..<keywordVM.getTotalKeywordsCount() {
                layoutView.keywordCollectionView.deselectItem(at: IndexPath(row: i, section: 0), animated: false)
            }
        } else {
            Logger.debug(self.keywordVM.getPrevSelectedIndex())
            if self.keywordVM.getPrevSelectedIndex() == 0 {
                self.keywordVM.deselectAll()
                layoutView.keywordCollectionView.deselectItem(at: IndexPath(row: 0, section: 0), animated: false)
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

extension SummarizeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = UILabel()
        label.text = keywordVM.getKeyword(index: indexPath.row)
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        
        let size = label.frame.size
        return CGSize(width: size.width + 40, height: size.height + 16)
    }
}
