//
//  InfoViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/22.
//

import UIKit

struct InfoViewModel {
    func openAppStore() {
        guard let url = URL(string: BaseData.shared.appStoreOpenUrlString) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:])
    }
}
