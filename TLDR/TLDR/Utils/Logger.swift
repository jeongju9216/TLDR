//
//  Logger.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/25.
//

import Foundation

final class Logger {
    
    private static var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    static func debug<T>(_ object: T?, line: Int = #line, funcName: String = #function) {
        #if DEBUG
        if let obj = object {
            print("[DEBUG] \(date) (\(line)): \(funcName): \(obj)")
        } else {
            print("[DEBUG] \(date) (\(line)): \(funcName): nil")
        }
        #endif
    }
    
    static func info<T>(_ object: T?, line: Int = #line, funcName: String = #function) {
        #if DEBUG
        if let obj = object {
            print("[INFO] \(date) (\(line)): \(funcName): \(obj)")
        } else {
            print("[INFO] \(date) (\(line)): \(funcName): nil")
        }
        #endif
    }
    
    static func error<T>(_ object: T?, line: Int = #line, funcName: String = #function) {
        #if DEBUG
        if let obj = object {
            print("[ERROR] \(date) (\(line)): \(funcName): \(obj)")
        } else {
            print("[ERROR] \(date) (\(line)): \(funcName): nil")
        }
        #endif
    }
}
