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
    @IBOutlet weak var keywordLabel1: UILabel! //임시
    
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
        if summarizeResult.summarizeKeywords.count > 1 {
            keywordLabel1.text = summarizeResult.summarizeKeywords[1]
        }
    }

}
