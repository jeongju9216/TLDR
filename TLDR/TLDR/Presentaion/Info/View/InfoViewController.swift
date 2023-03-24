//
//  InfoViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/22.
//

import UIKit

final class InfoViewController: BaseViewController<InfoView> {
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
    }
    
    //MARK: - Actions
    @objc private func clickedCloseButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func clickedUpdateButton() {
        openURL(BaseData.shared.appStoreOpenUrlString)
    }
    
    @objc private func clickedPolicyButton() {
        openURL(BaseData.shared.policyURL)
    }
    
    //MARK: - Methods
    private func addTargets() {
        self.layoutView.closeButton.addTarget(self,
                                              action: #selector(clickedCloseButton),
                                              for: .touchUpInside)
        self.layoutView.updateButton.addTarget(self,
                                              action: #selector(clickedUpdateButton),
                                              for: .touchUpInside)
        self.layoutView.policyButton.addTarget(self,
                                              action: #selector(clickedPolicyButton),
                                              for: .touchUpInside)
    }
    
    private func openURL(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        UIApplication.shared.open(url)
    }
}

