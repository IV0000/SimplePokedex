//
//  NetworkError.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 22/06/22.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case response(statusCode: Int)
    case badUrl
    case urlSession(URLError?)
    case parsing(DecodingError?)
    case undefined
    
    var userDescription: String {
        switch self {
        case .parsing, .badUrl, .undefined:
            return "Something went wrong"
        case .response(_):
            return "Connection failed"
        case .urlSession(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }
    
    //Debugging description
    var description: String {
        switch self {
        case .parsing(let error):
            return "parsing error: \(error?.localizedDescription ?? "")"
        case .badUrl:
            return "wrong URL"
        case .urlSession(let error):
            return error?.localizedDescription ?? "Error URL session"
        case .undefined:
            return "unknown error"
        case .response(statusCode: let statusCode):
            return "response error with code: \(statusCode)"
        }
    }
}
