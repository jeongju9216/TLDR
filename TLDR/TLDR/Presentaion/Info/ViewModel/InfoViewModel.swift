//
//  InfoViewModel.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/22.
//

import UIKit
import JeongLogger

struct InfoViewModel {
    func openURL(_ url: String) {
        JeongLogger.log(url)
        if let url = URL(string: url)  {
            UIApplication.shared.open(url)
        } else {
            JeongLogger.error("URL 에러")
        }
    }
}
