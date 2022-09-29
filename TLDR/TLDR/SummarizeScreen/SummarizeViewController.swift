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
    private var textMode: TextMode = .summarize
    
    private var selectedKeywords: Set<String> = []
    private var prevSelectIndex: Int = 0
    
    private var keywordViewModel: KeywordViewModel = KeywordViewModel()
    private var textModeViewModel: TextModeViewModel = TextModeViewModel()

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        setupNavigationBar() //네비게이션 세팅
        self.layoutView.setup()
        self.layoutView.setText(summarizeData.summarizeText)
        
        addTargets()
        bind()
        
        setupCollectionView()
        selectFirstItem()
    }
    
    //MARK: - Actions
    @objc private func clickedTextModeButton() {
        textMode = (textMode == .original) ? .summarize : .original
        textModeViewModel.setTextMode(textMode)
    }
    
    //MARK: - Methods
    private func bind() {
        keywordViewModel.keywords.bind { [weak self] selectedKeywords in
            self?.selectedKeywords = selectedKeywords
            self?.layoutView.highlightKeywords(selectedKeywords)
        }
        
        textModeViewModel.textMode.bind { [weak self] textMode in
            guard let self = self else { return }
            Logger.info(textMode)
            
            switch textMode {
            case .original:
                self.layoutView.setText(self.summarizeData.text)
            case .summarize:
                self.layoutView.setText(self.summarizeData.summarizeText)
            }

            self.layoutView.setTextModeLayout(textMode)
            self.layoutView.highlightKeywords(self.selectedKeywords)
        }
    }
    
    private func setupCollectionView() {
        self.layoutView.keywordCollectionView.register(KeywordCell.classForCoder(), forCellWithReuseIdentifier: "keywordCellIdentifier")
        self.layoutView.keywordCollectionView.delegate = self
        self.layoutView.keywordCollectionView.dataSource = self
    }
    
    private func selectFirstItem() {
        self.keywordViewModel.setKeywords(summarizeData.keywords)
        layoutView.keywordCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .init())
    }
    
    private func addTargets() {
        self.layoutView.textModeButton.addTarget(self, action: #selector(clickedTextModeButton), for: .touchUpInside)
    }
}

extension SummarizeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return summarizeData.keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.layoutView.keywordCollectionView.dequeueReusableCell(withReuseIdentifier: "keywordCellIdentifier", for: indexPath) as! KeywordCell
        
        let keyword = summarizeData.keywords[indexPath.row]
        cell.setKeyword(keyword)
        
        return cell
    }
}

extension SummarizeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.keywordViewModel.setKeywords(summarizeData.keywords)
            for i in 1..<summarizeData.keywords.count {
                layoutView.keywordCollectionView.deselectItem(at: IndexPath(row: i, section: 0), animated: false)
            }
        } else {
            if prevSelectIndex == 0 {
                self.keywordViewModel.allRemove()
            }
            
            self.keywordViewModel.selectedKeyword(summarizeData.keywords[indexPath.row])
            layoutView.keywordCollectionView.deselectItem(at: IndexPath(row: 0, section: 0), animated: false)
        }
        
        prevSelectIndex = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.keywordViewModel.allRemove()
        } else {
            self.keywordViewModel.deselectedKeyword(summarizeData.keywords[indexPath.row])
        }
    }
}

extension SummarizeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = UILabel()
        label.text = summarizeData.keywords[indexPath.row]
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        
        let size = label.frame.size
        return CGSize(width: size.width + 40, height: size.height + 16)
    }
}
