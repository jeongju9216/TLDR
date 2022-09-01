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
    
    var hideKeyboardButton: UIButton!
    
    //MARK: - Properties
    private var statusBarHeight: CGFloat = SizeUtil.statusBarHeight
    private var topBarHeight: CGFloat {
        return 50 + statusBarHeight
    }
    private var animationDuration: Double = 0.3
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Methods
    func showTopBar() {
        self.textView.textContainerInset = UIEdgeInsets(top: 60, left: 15, bottom: 10, right: 15)
        
        UIView.animate(withDuration: animationDuration, animations: {
            let scale = CGAffineTransform(translationX: 0, y: 0)
            self.topBarView.transform = scale
            
            self.topBarView.alpha = 1
        })
    }
    
    func hideTopBar() {
        self.textView.textContainerInset = UIEdgeInsets(top: 20, left: 15, bottom: 250, right: 15)

        UIView.animate(withDuration: animationDuration, animations: {
            let scale = CGAffineTransform(translationX: 0, y: -(self.topBarHeight))
            self.topBarView.transform = scale
            
            self.topBarView.alpha = 0
        })
    }
    
    func showSumUpButton() {
        UIView.animate(withDuration: animationDuration, animations: {
            let scale = CGAffineTransform(translationX: 0, y: 0)
            self.sumUpButton.transform = scale
            
            self.sumUpButton.alpha = 1
        })
    }
    
    func hideSumUpButton() {
        UIView.animate(withDuration: animationDuration, animations: {
            let scale = CGAffineTransform(translationX: 0, y: 80)
            self.sumUpButton.transform = scale
            
            self.sumUpButton.alpha = 0
        })
    }
    
    //MARK: - Setup
    private func setup() {
        setupTopBarView()
        setupTitleLable()
        
        setupSumUpButton()
        setupHideKeyboardButton()
        
        setupTextView()
        
        self.bringSubviewToFront(topBarView)
    }
    
    private func setupTopBarView() {
        topBarView = UIView(frame: .init(x: 0, y: 0, width: self.bounds.width, height: topBarHeight))
        
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
        textView.backgroundColor = .backgroundColor
        
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textContainerInset = UIEdgeInsets(top: 60, left: 15, bottom: 10, right: 15)
        
        textView.inputAccessoryView = hideKeyboardButton
        
        self.addSubview(textView)
        textView.pinWidth(constant: self.bounds.width)
        textView.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
        textView.pinBottom(to: self.sumUpButton.topAnchor)
    }
    
    private func setupSumUpButton() {
        sumUpButton = UIButton(type: .custom)
        
        sumUpButton.setBackgroundColor(.mainColor, for: .normal)
        
        sumUpButton.setTitle("요약하기", for: .normal)
        sumUpButton.setTitleColor(.white, for: .normal)
        sumUpButton.setTitleColor(.lightGray, for: .highlighted)
        
        sumUpButton.titleLabel?.textAlignment = .center
        sumUpButton.titleLabel?.font = .boldSystemFont(ofSize: 21)
        
        self.addSubview(sumUpButton)
        sumUpButton.pinWidth(constant: self.bounds.width)
        sumUpButton.pinHeight(constant: 80)
        sumUpButton.pinBottom(to: self.bottomAnchor)
    }
    
    private func setupHideKeyboardButton() {
        hideKeyboardButton = UIButton(type: .custom)
        
        hideKeyboardButton.backgroundColor = .backgroundColor
        
        hideKeyboardButton.setTitle("⌵", for: .normal)
        hideKeyboardButton.setTitleColor(.label, for: .normal)
        
//        hideKeyboardButton.titleLabel?.textAlignment = .center
        hideKeyboardButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        hideKeyboardButton.titleLabel?.font = .boldSystemFont(ofSize: 32)
        
        self.addSubview(hideKeyboardButton)
        hideKeyboardButton.pinWidth(constant: self.bounds.width)
        hideKeyboardButton.pinHeight(constant: 20)
    }
}
