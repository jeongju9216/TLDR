//
//  Loggable.swift
//  TLDR
//
//  Created by 유정주 on 2023/04/02.
//

import Foundation
import OSLog
import JeongLogger

protocol Loggable {
    func log(_ level: OSLogType, _ log: String)
}


extension Loggable {
    func log(_ level: OSLogType = .default, _ log: String) {
        JeongLogger.log(log, level: level)
    }
    
    func log<T>(_ level: OSLogType = .default, _ object: T?) {
        JeongLogger.log(object, level: level)
    }
}
