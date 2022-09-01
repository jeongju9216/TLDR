//
//  LaunchView.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class LaunchView: UIView {
    
    //MARK: - Views
    private var titleLabel: UILabel!
    
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
        setupTitleLable()
    }
    
    private func setupTitleLable() {
        titleLabel = UILabel()
        
        titleLabel.text = "TL;DR"
        titleLabel.textColor = .mainColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        self.addSubview(titleLabel)
        titleLabel.pinCenter(ofView: self)
    }
}
