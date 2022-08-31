//
//  BaseViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

class BaseViewController<LayoutView: UIView>: UIViewController {
    var layoutView: LayoutView {
        return view as! LayoutView
    }
    
    override func loadView() {
        self.view = LayoutView(frame: UIScreen.main.bounds)
    }
}
