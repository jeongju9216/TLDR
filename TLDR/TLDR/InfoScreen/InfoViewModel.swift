//
//  InfoViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/22.
//

import UIKit

struct InfoViewModel {
    func openURL(_ url: String) {
        Logger.debug(url)
        if let url = URL(string: url)  {
            UIApplication.shared.open(url)
        } else {
            Logger.error("URL 에러")
        }
    }
}
