//
//  CustomError.swift
//  Hello
//
//  Created by Ron White on 12/30/21.
//

import Foundation

enum CustomError: Error
{
    case invalidRequest
    case notFound
    case unexpected(code: Int)
}

extension CustomError: CustomStringConvertible
{
    public var description: String {
        switch self {
        case .invalidRequest: return "The request is not valid."
        case .notFound: return "That resource was not available or addressable."
        case .unexpected(_): return "An unexpected error occured, try again later."
        }
    }
}
