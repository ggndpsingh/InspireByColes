//
//  Time.swift
//  ColesInspire
//

import Foundation

public extension Recipe {
    struct Time: Decodable, Sendable {
        public let label: String
        public let duration: Duration
        public let note: String?

        init(label: String, durationAsMinutes: Int, note: String? = nil) {
            self.label = label
            self.duration = .seconds(durationAsMinutes * 60)
            self.note = note
        }
    }
}
