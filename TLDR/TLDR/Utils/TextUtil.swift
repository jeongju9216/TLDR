//
//  TextUtil.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/03.
//

import UIKit

final class TextUtil {
    
    static let fontSize: CGFloat = 18
    static let lineHeight: CGFloat = 1.6
    static let textViewStyle: [NSAttributedString.Key: Any] = [
        .paragraphStyle: {
            let style = NSMutableParagraphStyle()
            
            let lineheight: CGFloat = fontSize * lineHeight
            style.minimumLineHeight = lineheight
            style.maximumLineHeight = lineheight

            print("fontSize * lineHeight: \(fontSize * lineHeight)")
            return style
        }(),
        .font: UIFont.systemFont(ofSize: fontSize),
        .foregroundColor: UIColor.label
    ]
}
