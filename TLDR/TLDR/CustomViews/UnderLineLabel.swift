//
//  UnderLineLabel.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/01.
//

import UIKit

final class UnderLineLabel: UIView {
    
    //MARK: - Views
    private var label: UILabel!
    private var lineView: LineView!
    
    //MARK: - Properties
    private var title: String = ""
    private var fontSize: CGFloat = 0
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(frame: CGRect = .zero, title: String, fontSize: CGFloat = 21) {
        self.init(frame: frame)
        
        self.title = title
        self.fontSize = fontSize
        
        setup()
        setupLineView()
    }
    
    func changeTitle(_ title: String) {
        self.label.text = title
    }
    
    //MARK: - Setup
    private func setup() {
        label = UILabel()
        
        label.text = title
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        
        self.addSubview(label)
        label.pinLeft(to: self.leftAnchor, offset: 0)
    }
    
    private func setupLineView() {
        lineView = LineView()
        lineView.backgroundColor = .label
        
        self.addSubview(lineView)
        lineView.pinWidth(to: self.label.widthAnchor, constant: 0)
        lineView.pinHeight(constant: 3)
        lineView.pinLeft(to: self.label.leftAnchor)
        lineView.pinTop(to: self.label.bottomAnchor, offset: 3)
    }
}
