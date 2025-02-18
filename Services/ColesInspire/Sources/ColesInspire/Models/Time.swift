//
//  Time.swift
//  ColesInspire
//

import Foundation

public extension Recipe {
    struct Time: Decodable, Sendable, Equatable {
        public let label: String
        public let duration: Duration
        public let note: String?

        init(label: String, duration: Duration, note: String? = nil) {
            self.label = label
            self.duration = duration
            self.note = note
        }
    }
}

public extension Recipe.Time {
    init(label: String, durationAsMinutes: Int, note: String? = nil) {
        self.init(label: label, duration: .seconds(durationAsMinutes * 60), note: note)
    }
}
