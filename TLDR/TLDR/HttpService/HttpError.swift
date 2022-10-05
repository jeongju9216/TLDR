//
//  HttpError.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/20.
//

import Foundation

enum HttpError: Error {
    case serverStateError(notice: String)
    case statusCodeError
    case urlError
    case jsonError
    case apiError
    case summarizeError(message: String)
}
