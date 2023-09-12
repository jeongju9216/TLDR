//
//  BaseData.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/02.
//

import UIKit

final class BaseData {
    static var shared = BaseData()
    private init() { }
    
    var appleID = ""
    var bundleID = ""
    var appStoreOpenUrlString: String { //앱 스토어 url
        "itms-apps://itunes.apple.com/app/apple-store/\(appleID)"
    }
    
    var currentVersion = "" //현재버전
    var lastetVersion = "" //최신버전
    var forcedUpdateVersion = "" //강제 업데이트 버전
    
    var serverDomain: String = ""
    var policyURL: String = ""
}

extension BaseData {
    var isNeedUpdate: Bool { //업데이트가 필요한가?
        compareVersion(curruent: currentVersion, compare: lastetVersion)
    }
    
    var isNeedForcedUpdate: Bool { //강제 업데이트가 필요한가?
        compareVersion(curruent: currentVersion, compare: forcedUpdateVersion)
    }
    
    private func compareVersion(curruent: String, compare: String) -> Bool {
        let compareResult = curruent.compare(compare, options: .numeric)
        return compareResult == .orderedAscending
    }
}
