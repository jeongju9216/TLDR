//
//  StateData.swift
//  TLDR
//
//  Created by 유정주 on 2022/10/02.
//

import Foundation

struct StateData: Codable {
    let state: Result //서버 상태 정상: ok, 비정상: fail
    let notice: String //서버 공지(안내 메시지)
}
