//
//  UIColor.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

extension UIColor {
    static var backgroundColor: UIColor {
        return UIColor(named: "BackgroundColor") ?? .black
    }
    
    static var mainColor: UIColor {
        return UIColor(named: "MainColor") ?? .black
    }
    
    static var darkColor: UIColor {
        return UIColor(named: "DarkColor") ?? .black
    }
    
    static var selectedKeywordColor: UIColor {
        return UIColor(named: "SelectedKeywordColor") ?? .black
    }
    
    static var deselectedKeywordColor: UIColor {
        return UIColor(named: "DeselectedKeywordColor") ?? .black
    }
}
