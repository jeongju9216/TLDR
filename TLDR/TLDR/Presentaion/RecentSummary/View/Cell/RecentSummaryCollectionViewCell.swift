//
//  RecentSummaryCollectionViewCell.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/05.
//

import UIKit

final class RecentSummaryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var keywordLabel1: UILabel!
    
    //MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Methods
    func configuration(summarizeResult: SummarizeResult) {
        summaryLabel.text = summarizeResult.summarizeText
        if summarizeResult.summarizeKeywords.count > 1 {
            keywordLabel1.text = summarizeResult.summarizeKeywords[1]
        }
    }

}
