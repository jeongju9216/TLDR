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
    
    var summarizeButton: UIButton!
    
    var hideKeyboardButton: UIButton!
    
    //MARK: - Properties
    private var fontSize: CGFloat = 18.0
    private var statusBarHeight: CGFloat = SizeUtil.statusBarHeight
    private var topBarHeight: CGFloat {
        return 40 + statusBarHeight
    }
    private var animationDuration: Double = 0.3
    let testString = "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세"
    
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
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 15)
        
        UIView.animate(withDuration: animationDuration, animations: {
            let scale = CGAffineTransform(translationX: 0, y: 0)
            self.topBarView.transform = scale
            self.textView.transform = scale
            
            self.topBarView.alpha = 1
        })
    }
    
    func hideTopBar() {
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 300, right: 15)
        
        UIView.animate(withDuration: animationDuration, animations: {
            let scale = CGAffineTransform(translationX: 0, y: -(self.topBarHeight))
            self.topBarView.transform = scale
            
            let scale2 = CGAffineTransform(translationX: 0, y: -(self.topBarHeight - self.statusBarHeight))
            self.textView.transform = scale2
            
            self.topBarView.alpha = 0
        })
    }
    
    func showSummarizeButton() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.summarizeButton.alpha = 1
        })
    }
    
    func hideSummarizeButton() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.summarizeButton.alpha = 0
        })
    }
    
    //MARK: - Setup
    private func setup() {        
        setupTopBarView()
        setupTitleLable()
        
        setupSummarizeButton()
        setupHideKeyboardButton()
        
        setupTextView()
        
        self.bringSubviewToFront(topBarView)
    }
    
    private func setupTopBarView() {
        topBarView = UIView(frame: .init(x: 0, y: 0, width: self.bounds.width, height: topBarHeight))
        
        topBarView.backgroundColor = .backgroundColor
        
        topBarView.layer.masksToBounds = false
        topBarView.layer.shadowColor = UIColor.label.cgColor
        topBarView.layer.shadowOffset = .zero
        topBarView.layer.shadowRadius = 1
        topBarView.layer.shadowOpacity = 0.2
                
        self.addSubview(topBarView)
    }
    
    private func setupTitleLable() {
        titleLabel = UILabel(frame: .init(x: 0, y: statusBarHeight, width: self.bounds.width, height: topBarHeight - statusBarHeight))
        
        titleLabel.text = "TL;DR"
        titleLabel.textColor = .label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        topBarView.addSubview(titleLabel)
    }
    
    private func setupTextView() {
        textView = UITextView()
        textView.backgroundColor = .backgroundColor
        
        textView.applyTextWithLineHeight(string: testString)
        textView.textColor = .label
        textView.font = UIFont.systemFont(ofSize: fontSize)
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 15)
        
        textView.inputAccessoryView = hideKeyboardButton
        
        self.addSubview(textView)
        textView.pinWidth(constant: self.bounds.width)
        textView.pinTop(to: self.topBarView.bottomAnchor)
        textView.pinBottom(to: self.summarizeButton.topAnchor)
    }
    
    private func setupSummarizeButton() {
        summarizeButton = UIButton(type: .custom)
        
        summarizeButton.setBackgroundColor(.mainColor, for: .normal)
        
        summarizeButton.setTitle("요약하기", for: .normal)
        summarizeButton.setTitleColor(.white, for: .normal)
        summarizeButton.setTitleColor(.lightGray, for: .highlighted)
        
        summarizeButton.titleLabel?.textAlignment = .center
        summarizeButton.titleLabel?.font = .boldSystemFont(ofSize: 21)
        
        self.addSubview(summarizeButton)
        summarizeButton.pinWidth(constant: self.bounds.width)
        summarizeButton.pinHeight(constant: 80)
        summarizeButton.pinBottom(to: self.bottomAnchor)
    }
    
    private func setupHideKeyboardButton() {
        hideKeyboardButton = UIButton(type: .custom)
        
        hideKeyboardButton.backgroundColor = .backgroundColor
        
        hideKeyboardButton.setTitle("⌵", for: .normal)
        hideKeyboardButton.setTitleColor(.label, for: .normal)
        hideKeyboardButton.titleLabel?.font = .boldSystemFont(ofSize: 32)

        self.addSubview(hideKeyboardButton)
        hideKeyboardButton.pinWidth(constant: self.bounds.width)
        hideKeyboardButton.pinHeight(constant: 35)
    }
}
