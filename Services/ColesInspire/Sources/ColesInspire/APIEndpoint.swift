//
//  File.swift
//  ColesInspire
//

import Foundation

extension InspirationService {
    enum APIEndpoint {
        case production
    }
}

extension InspirationService.APIEndpoint {
    var baseURL: URL {
        switch self {
        case .production:
            return URL(string: "https://coles.com.au")!
        }
    }
}
