//
//  VersionData.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/25.
//

import Foundation

//todo
//Wrap 클래스로 struct 최적화 하기
struct VersionData: Decodable {
    let forced: String //강제 업데이트 버전
    let lasted: String //최신 버전
    let appleID: String //앱 애플 아이디
    let bundleID: String //번들 아이디
}
