//
//  VersionData.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/25.
//

import Foundation

struct VersionData: Decodable {
    let forced: String //강제 업데이트 버전
    let lasted: String //최신 버전
    let appleID: String //앱 애플 아이디
    let bundleID: String //번들 아이디
}
