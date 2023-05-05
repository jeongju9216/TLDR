//
//  RecentSummaryCollectionViewCell.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/05.
//

import UIKit

final class RecentSummaryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    @IBOutlet weak var testLabel: UILabel!
    
    //MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Methods
    func configuration(summarizeResult: SummarizeResult) {
        testLabel.text = "--- \(summarizeResult.summarizeText)"
    }

}
