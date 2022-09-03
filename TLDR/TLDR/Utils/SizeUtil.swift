//
//  SizeUtil.swift
//  GardenOfTranslation
//
//  Created by 유정주 on 2022/08/24.
//

import UIKit

final class SizeUtil {
    /**
     statusbar 높이 구하기
     */
    static var statusBarHeight: CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        let statusBarHeight: CGFloat = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        print("\(#line)-line, \(#function)")
        return statusBarHeight
    }
}
