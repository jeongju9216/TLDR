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
    func jlog(_ level: OSLogType, _ log: String)
}


extension Loggable {
    func jlog(_ level: OSLogType, _ log: String) {
        JeongLogger.log(log, level: level)
    }
    
    func jlog<T>(_ level: OSLogType, _ object: T?) {
        JeongLogger.log(object, level: level)
    }
}
