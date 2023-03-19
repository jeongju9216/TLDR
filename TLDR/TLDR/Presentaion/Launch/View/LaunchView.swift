//
//  LaunchView.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class LaunchView: UIView {
    
    //MARK: - Views
    //가운데 앱 이름
    private var titleLabel: UILabel = .init()
    
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
    
    //titleLabel 초기화
    private func setupTitleLable() {
        titleLabel.text = "TL;DR"
        titleLabel.textColor = .mainColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        self.addSubview(titleLabel)
        titleLabel.pinCenter(ofView: self)
    }
}
