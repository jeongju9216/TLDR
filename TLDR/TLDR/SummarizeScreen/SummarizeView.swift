//
//  SummarizeView.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import Foundation
import UIKit

final class SummarizeView: UIView {
    
    //MARK: - Views
    var textView: UITextView! //텍스트 입력창
    
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
    func scrollToTopTextView() {
        textView.setContentOffset(.zero, animated: false)
        textView.layoutIfNeeded()
    }
    
    
    //MARK: - Setup
    private func setup() {
        setupTextView()
    }
    
    private func setupTextView() {
        textView = UITextView()
        textView.backgroundColor = .backgroundColor
        
        textView.text = """
                        애국가 가사 1절
                        동해물과 백두산이 마르고 닳도록
                        하느님이 보우하사 우리나라 만세
                        무궁화 삼천리 화려강산
                        대한 사람 대한으로 길이 보전하세
                        
                        애국가 가사 2절
                        남산 위에 저 소나무 철갑을 두른 듯
                        바람 서리 불변함은 우리 기상일세
                        무궁화 삼천리 화려강산
                        대한 사람 대한으로 길이 보전하세
                        
                        애국가 가사 3절
                        가을 하늘 공활한데 높고 구름 없이
                        밝은 달은 우리 가슴 일편단심일세
                        무궁화 삼천리 화려강산
                        대한 사람 대한으로 길이 보전하세

                        애국가 가사 4절
                        이 기상과 이 맘으로 충성을 다하여
                        괴로우나 즐거우나 나라 사랑하세
                        무궁화 삼천리 화려강산
                        대한 사람 대한으로 길이 보전하세
                        """
        
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
                
        self.addSubview(textView)
        textView.pinWidth(constant: self.bounds.width)
        textView.pinHeight(constant: self.bounds.height * 0.5)
        textView.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
    }
}
