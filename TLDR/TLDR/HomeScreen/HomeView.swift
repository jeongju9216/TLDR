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
    private var topBarLineView: UIView!
    
    private var titleLabel: UILabel! //TLDR 라벨
    var resetButton: UIButton! //초기화 버튼
    var pasteButton: UIButton! //붙여넣기 버튼
    
    var textView: UITextView! //텍스트 입력창
    
    var summarizeButton: UIButton! //요약하기 버튼
    var hideKeyboardButton: UIButton! //키보드 숨김 버튼
    
    //MARK: - Properties
    private var topBarHeight: CGFloat = 35
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
    func setText(_ text: String) {
        self.textView.text = text
    }
    
    func setEnabled(_ toggle: Bool) {
        self.summarizeButton.isEnabled = toggle
    }
    
    //키보드 내려가면 탑바 보임
    func showTopBar() {
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 15)
        
        UIView.animate(withDuration: animationDuration, animations: {
            let scale = CGAffineTransform(translationX: 0, y: 0)
            self.topBarView.transform = scale
            self.textView.transform = scale
            
            self.topBarView.alpha = 1
        })
    }
    
    //키보드 올라가면 탑바 숨김
    func hideTopBar() {
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 300, right: 15)
        
        UIView.animate(withDuration: animationDuration, animations: {
            let scale = CGAffineTransform(translationX: 0, y: -self.topBarHeight)
            self.topBarView.transform = scale
            self.textView.transform = scale
            
            self.topBarView.alpha = 0
        })
    }
    
    //키보드 올라가면 요약하기 버튼 숨김
    func showSummarizeButton() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.summarizeButton.alpha = 1
        })
    }
    
    //키보드 올라가면 요약하기 버튼 보임
    func hideSummarizeButton() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.summarizeButton.alpha = 0
        })
    }
    
    //MARK: - Setup
    private func setup() {        
        setupTopBarView()
        setupTopBarLineView()

        setupTitleLable()
        setupPasteButton()
        setupResetButton()
        
        setupSummarizeButton()
        setupHideKeyboardButton()
        
        setupTextView()

        self.bringSubviewToFront(topBarView)
    }
    
    private func setupTopBarView() {
        topBarView = UIView(frame: .zero)
        
        topBarView.backgroundColor = .backgroundColor
        
        self.addSubview(topBarView)
        topBarView.pinHeight(constant: topBarHeight)
        topBarView.pinLeft(to: self.leftAnchor)
        topBarView.pinRight(to: self.rightAnchor)
        topBarView.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
    }
    
    private func setupTopBarLineView() {
        topBarLineView = UIView(frame: .zero)
        
        topBarLineView.backgroundColor = .lightGray
        topBarLineView.alpha = 0.2
        
        topBarView.addSubview(topBarLineView)
        topBarLineView.pinHeight(constant: 1)
        topBarLineView.pinLeft(to: self.leftAnchor)
        topBarLineView.pinRight(to: self.rightAnchor)
        topBarLineView.pinBottom(to: self.topBarView.bottomAnchor)
    }
    
    private func setupTitleLable() {
        titleLabel = UILabel()
        
        titleLabel.text = "TL;DR"
        titleLabel.textColor = .mainColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        topBarView.addSubview(titleLabel)
        titleLabel.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor, offset: 20)
        titleLabel.pinBottom(to: topBarView.bottomAnchor, offset: -5)
    }
    
    private func setupResetButton() {
        resetButton = UIButton(type: .custom)
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.label, for: .normal)
        resetButton.setTitleColor(.lightGray, for: .highlighted)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        resetButton.titleLabel?.textAlignment = .center
        
        topBarView.addSubview(resetButton)
        resetButton.pinRight(to: pasteButton.leftAnchor, offset: -15)
        resetButton.pinBottom(to: topBarView.bottomAnchor, offset: 0)
    }
    
    private func setupPasteButton() {
        pasteButton = UIButton(type: .custom)
        
        pasteButton.setTitle("Paste", for: .normal)
        pasteButton.setTitleColor(.label, for: .normal)
        pasteButton.setTitleColor(.lightGray, for: .highlighted)
        pasteButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        pasteButton.titleLabel?.textAlignment = .center
        
        topBarView.addSubview(pasteButton)
        pasteButton.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -20)
        pasteButton.pinBottom(to: topBarView.bottomAnchor, offset: 0)
    }
    
    private func setupTextView() {
        textView = UITextView()
        
        textView.backgroundColor = .backgroundColor
        textView.inputAccessoryView = hideKeyboardButton
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 15)

        textView.typingAttributes = TextUtil.textViewStyle
        
        self.addSubview(textView)
        textView.pinLeft(to: self.safeAreaLayoutGuide.leftAnchor)
        textView.pinRight(to: self.safeAreaLayoutGuide.rightAnchor)
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
        
        summarizeButton.pinHeight(constant: 80)
        summarizeButton.pinLeft(to: self.leftAnchor)
        summarizeButton.pinRight(to: self.rightAnchor)
        summarizeButton.pinBottom(to: self.bottomAnchor)
    }
    
    private func setupHideKeyboardButton() {
        hideKeyboardButton = UIButton(type: .custom)
        
        hideKeyboardButton.backgroundColor = .backgroundColor
        
        hideKeyboardButton.setTitle("⌵", for: .normal)
        hideKeyboardButton.setTitleColor(.label, for: .normal)
        hideKeyboardButton.titleLabel?.font = .boldSystemFont(ofSize: 32)

        self.addSubview(hideKeyboardButton)
        hideKeyboardButton.pinLeft(to: self.leftAnchor)
        hideKeyboardButton.pinRight(to: self.rightAnchor)
        hideKeyboardButton.pinHeight(constant: 35)
    }
}
