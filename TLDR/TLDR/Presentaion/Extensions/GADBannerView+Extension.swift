//
//  GADBannerView+Extension.swift
//  TLDR
//
//  Created by 유정주 on 1/4/24.
//

import UIKit
import GoogleMobileAds

extension GADBannerView {
    static func createBannerView() -> GAMBannerView {
        let bannerView = GAMBannerView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        bannerView.adUnitID = "ca-app-pub-1032958823703674/2617462420"
        
        return bannerView
    }
    
    func showSmoothly() {
        self.alpha = 0
        UIView.animate(withDuration: 1) {
            self.alpha = 1
        }
    }
}
