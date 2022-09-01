//
//  UITextView.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import UIKit

extension UITextView {
    func applyTextWithLineHeight(string: String, _ lineHeight: CGFloat = 1.6) {
        let style = NSMutableParagraphStyle()
        let lineheight = 18 * 1.6
        style.minimumLineHeight = lineheight
        style.maximumLineHeight = lineheight
        self.attributedText = NSAttributedString(
            string: string,
            attributes: [
                .paragraphStyle: style
            ]
        )
    }
}
