//
//  UITextView.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import UIKit

extension UITextView {
    func applyLineHeight(fontSize: CGFloat = TextUtil.fontSize, _ lineHeight: CGFloat = TextUtil.lineHeight) {
        self.attributedText = NSAttributedString(string: self.text, attributes: TextUtil.textViewStyle)
    }
    
    func highlightKeywords(_ keywords: Set<String>, color: UIColor = .mainColor) {
        
        let attrString = NSMutableAttributedString(string: self.text, attributes: TextUtil.textViewStyle)
        
        if let text = self.text {
            for keyword in keywords {
                var searchRange = text.startIndex..<text.endIndex
                while let range = text.range(of: keyword, options: .caseInsensitive, range: searchRange) {
                    attrString.addAttribute(.foregroundColor, value: color, range: NSRange(range, in: text))
                    attrString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: TextUtil.fontSize), range: NSRange(range, in: text))
                    
                    searchRange = range.upperBound..<searchRange.upperBound
                }
            }
        }
        
        self.attributedText = attrString
    }
}
