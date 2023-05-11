//
//  RecentSummaryCollectionViewCell.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/05.
//

import UIKit

final class RecentSummaryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var keywordStackView: UIStackView!
    private let maxKeywordsCount = 3
    
    //MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    //MARK: - Setup
    private func setupUI() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10

        layer.masksToBounds = false
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .init(width: 0, height: 3)
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    //MARK: - Methods
    func configuration(summarizeResult: SummarizeResult) {
        summaryLabel.text = summarizeResult.summarizeText
        
        keywordStackView.subviews.forEach { $0.removeFromSuperview() }
        
        let keywordCount = summarizeResult.summarizeKeywords.count - 1
        for i in 1...maxKeywordsCount {
            if keywordCount >= i {
               addKeywords(summarizeResult.summarizeKeywords[i])
            } else {
                addBlankItem()
            }
        }
    }
    
    private func addKeywords(_ keyword: String) {
        let label = UILabel(frame: .zero)
        
        label.text = keyword
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = (keywordStackView.frame.height/2)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.selectedKeywordColor.cgColor
                
        keywordStackView.addArrangedSubview(label)
    }
    
    private func addBlankItem() {
        keywordStackView.addArrangedSubview(UIView())
    }
}
