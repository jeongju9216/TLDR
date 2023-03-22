//
//  KeywordCell.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/29.
//

import UIKit

final class KeywordCell: UICollectionViewCell {
    //MARK: - Views
    static let id: String = String(describing: KeywordCell.self)
    private var label: UILabel!
    
    //MARK: - Properties
    override var isSelected: Bool {
        didSet {
            setSelected(isSelected)
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Methods
    func setKeyword(_ text: String) {
        label.text = text
    }
    
    private func setSelected(_ isSelected: Bool) {
        if isSelected {
            setSelectedStyle()
        } else {
            setDeselectedStyle()
        }
    }
    
    //선택되었을 때 cell style
    private func setSelectedStyle() {
        label.textColor = .deselectedKeywordColor
        
        contentView.backgroundColor = .selectedKeywordColor
        contentView.layer.borderColor = UIColor.deselectedKeywordColor.cgColor
    }
    
    //선택 해제되었을 때 cell style
    private func setDeselectedStyle() {
        label.textColor = .selectedKeywordColor
        
        contentView.backgroundColor = .deselectedKeywordColor
        contentView.layer.borderColor = UIColor.selectedKeywordColor.cgColor
    }
    
    //MARK: - Setup
    private func setupCell() {
        label = UILabel(frame: .zero)
    
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = (contentView.frame.height/2)
        
        contentView.layer.borderWidth = 1
        
        setDeselectedStyle()
        
        contentView.addSubview(label)
        label.pinCenter(ofView: contentView)
    }
}
