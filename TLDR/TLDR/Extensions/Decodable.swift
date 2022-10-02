//
//  Decodable.swift
//  TLDR
//
//  Created by 유정주 on 2022/10/02.
//

import Foundation

extension Decodable {
    static func decode<T: Decodable>(dictionary: [String: Any]) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [.fragmentsAllowed])
        return try JSONDecoder().decode(T.self, from: data)
    }
}
