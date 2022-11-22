//
//  InfoView.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/22.
//

import UIKit

final class InfoView: UIView {
    
    //MARK: - Views
    var closeButton: UIButton!
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var versionLabel: UILabel!
    var policyButton: UIButton!
    var updateButton: UIButton!
    
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
        setupCloseButton()
        setupIconImage()
        setupTitleLabel()
        setupVersionLabel()
        
        setupUpdateButton()
        setupPolicyButton()
    }
    
    private func setupCloseButton() {
        closeButton = UIButton()
        
        closeButton.setTitle("닫기", for: .normal)
        closeButton.setTitleColor(.label, for: .normal)
        
        self.addSubview(closeButton)
        closeButton.pinTop(to: self.safeAreaLayoutGuide.topAnchor, offset: 20)
        closeButton.pinRight(to: self.safeAreaLayoutGuide.rightAnchor, offset: -20)
    }
    
    private func setupIconImage() {
        if let iconImage = UIImage(named: "AppIconImage") {
            iconImageView = UIImageView(image: iconImage)
        } else {
            iconImageView = UIImageView()
        }
        
        let size: CGFloat = 120
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = size / 5
        
        self.addSubview(iconImageView)
        iconImageView.pinWidth(constant: size)
        iconImageView.pinHeight(constant: size)
        iconImageView.pinCenterX(to: self.centerXAnchor)
        iconImageView.pinTop(to: closeButton.bottomAnchor, offset: 20)
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "TLDR"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        self.addSubview(titleLabel)
        titleLabel.pinCenterX(to: self.centerXAnchor)
        titleLabel.pinTop(to: iconImageView.bottomAnchor, offset: 20)
    }
    
    private func setupVersionLabel() {
        versionLabel = UILabel()
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.numberOfLines = 0
        
        versionLabel.text = "현재 버전 : \(BaseData.shared.currentVersion)\n최신 버전 : \(BaseData.shared.lastetVersion)"
        versionLabel.font = UIFont.systemFont(ofSize: 16)
        
        self.addSubview(versionLabel)
        versionLabel.pinCenterX(to: self.centerXAnchor)
        versionLabel.pinTop(to: titleLabel.bottomAnchor, offset: 20)
    }
    
    private func setupUpdateButton() {
        updateButton = UIButton()

        let title: String = BaseData.shared.isNeedUpdate ? "최신 버전으로 업데이트" : "최신 버전"
        
        updateButton.clipsToBounds = true
        updateButton.layer.masksToBounds = true
        
        updateButton.setBackgroundColor(.mainColor, for: .normal)
        updateButton.layer.cornerRadius = 20 //heigth: 40 고정
        
        updateButton.setTitle(title, for: .normal)
        updateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.setTitleColor(.lightGray, for: .highlighted)
        
        if UITraitCollection.current.userInterfaceStyle == .light {
            updateButton.setTitleColor(.white, for: .disabled)
        } else {
            updateButton.setTitleColor(.lightGray, for: .disabled)
        }
        
        updateButton.isEnabled = BaseData.shared.isNeedUpdate
        
        let width = min(self.frame.width - 80, 800)
        self.addSubview(updateButton)
        updateButton.pinWidth(constant: width)
        updateButton.pinHeight(constant: 40)
        updateButton.pinCenterX(to: self.centerXAnchor)
        updateButton.pinBottom(to: self.safeAreaLayoutGuide.bottomAnchor, offset: -20)
    }
    
    private func setupPolicyButton() {
        policyButton = UIButton()
        
        policyButton.setTitle("개인정보처리방침", for: .normal)
        policyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        policyButton.setTitleColor(.systemBlue, for: .normal)
        
        self.addSubview(policyButton)
        policyButton.pinBottom(to: updateButton.topAnchor, offset: -5)
        policyButton.pinCenterX(to: updateButton.centerXAnchor)
    }
}
