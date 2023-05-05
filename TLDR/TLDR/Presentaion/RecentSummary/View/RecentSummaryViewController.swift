//
//  RecentSummaryViewController.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/05.
//

import UIKit

final class RecentSummaryViewController: UIViewController {

    private let recentSummaryVM: RecentSummaryViewModel = RecentSummaryViewModel()
    private lazy var recentSummaries: [SummarizeResult] = {
        do {
            return try recentSummaryVM.action(.recentSummary).value() as! [SummarizeResult]
        } catch {
            return []
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(recentSummaries)
    }
    
     
}
