//
//  HomeView.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class HomeView: UIView {
    
    //MARK: - Views
    private var topBarView: UIView! //상단바(네비바 모양)
    private var titleLabel: UILabel!
    
    private var textView: UITextView! //텍스트 입력창
    
    var sumUpButton: UIButton!
    
    //MARK: - Properties
    private var statusBarHeight: CGFloat = SizeUtil.statusBarHeight
    private var topBarHeight: CGFloat {
        return 50 + statusBarHeight
    }
    
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
        setupTitleLable()
        setupTextView()
        setupSumUpButton()
        
        self.bringSubviewToFront(topBarView)
    }
    
    private func setupTopBarView() {
        topBarView = UIView(frame: .init(x: 0, y: 0,
                                        width: self.bounds.width, height: topBarHeight))
        
        topBarView.backgroundColor = .darkColor
                
        self.addSubview(topBarView)
    }
    
    private func setupTitleLable() {
        titleLabel = UILabel(frame: .init(x: 0, y: statusBarHeight, width: self.bounds.width, height: 50))
        
        titleLabel.text = "TL;DR"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        topBarView.addSubview(titleLabel)
    }
    
    private func setupTextView() {
        textView = UITextView()
        
        self.addSubview(textView)
        textView.pinWidth(constant: self.bounds.width)
        textView.pinTop(to: self.topBarView.bottomAnchor)
        textView.pinBottom(to: self.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func setupSumUpButton() {
        sumUpButton = UIButton(type: .custom)
        
        sumUpButton.setBackgroundColor(.mainColor, for: .normal)
        
        sumUpButton.setTitle("요약하기", for: .normal)
        sumUpButton.setTitleColor(.white, for: .normal)
        sumUpButton.setTitleColor(.lightGray, for: .highlighted)
        
        sumUpButton.titleLabel?.textAlignment = .center
        sumUpButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        self.addSubview(sumUpButton)
        sumUpButton.pinWidth(constant: self.bounds.width)
        sumUpButton.pinHeight(constant: 80)
        sumUpButton.pinBottom(to: self.bottomAnchor)
    }
}
