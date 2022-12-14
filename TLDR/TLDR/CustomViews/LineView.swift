//
//  LineView.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import UIKit

final class LineView: UIView {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Setup
    private func setup() {
        self.backgroundColor = .label
    }
}
