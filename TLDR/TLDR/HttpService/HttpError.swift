//
//  HttpError.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/20.
//

import Foundation

enum HttpError: Error {
    case statusCodeError
    case urlError
    case jsonError
    case apiError
}
