//
//  TopBarView.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/23.
//

import UIKit

final class TopBarView: UIView {
    
    //MARK: - Views
    private var topBarView: UIView! //상단바(네비바 모양)
    private var topBarLineView: UIView!

    //MARK: - Properties
    var height: CGFloat {
        topBarHeight + lineHeight
    }
    private var topBarHeight: CGFloat = 40
    private var lineHeight: CGFloat = 1
    
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
        setupTopBarView()
        setupTopBarLineView()
    }
    
    private func setupTopBarView() {
        topBarView = UIView(frame: .zero)
        
        topBarView.backgroundColor = .backgroundColor
        
        self.addSubview(topBarView)
        topBarView.pinHeight(constant: topBarHeight)
    }
    
    private func setupTopBarLineView() {
        topBarLineView = UIView(frame: .zero)
        
        topBarLineView.backgroundColor = .lightGray
        topBarLineView.alpha = 0.2
        
        topBarView.addSubview(topBarLineView)
        topBarLineView.pinHeight(constant: lineHeight)
        topBarLineView.pinLeft(to: super.leftAnchor)
        topBarLineView.pinRight(to: super.rightAnchor)
        topBarLineView.pinBottom(to: super.bottomAnchor)
    }

}
