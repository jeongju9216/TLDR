//
//  RecentSummaryDelegate.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/07.
//

import Foundation

//최근 요약 리스트 아이템 클릭
protocol RecentSummaryDelegate: AnyObject {
    func didSelectRecentSummaryCell(_ summarizeResult: SummarizeResult)
}
