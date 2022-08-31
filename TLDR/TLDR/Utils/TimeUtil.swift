//
//  TimeUtils.swift
//  GardenOfTranslation
//
//  Created by 유정주 on 2022/08/09.
//

import Foundation

final class TimeUtil {
    static func nano2sec(_ sec: Double) -> UInt64 {
        return UInt64(sec * 1_000_000_000)
    }
}
