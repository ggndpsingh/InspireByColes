//
//  Image.swift
//  ColesInspire
//

import Foundation

public extension Recipe {
    struct Image: Decodable, Sendable {
        public let path: String
        public let alt: String
    }
}
