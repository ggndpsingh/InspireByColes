//
//  Image.swift
//  ColesInspire
//

import Foundation

public extension Recipe {
    struct Image: Decodable, Sendable, Equatable, Hashable {
        public let path: String
        public let alt: String

        public init(path: String, alt: String) {
            self.path = path
            self.alt = alt
        }
    }
}
