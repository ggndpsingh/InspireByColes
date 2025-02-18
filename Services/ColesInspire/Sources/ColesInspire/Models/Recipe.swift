//
//  File.swift
//  ColesInspire
//

import Foundation

public struct Recipe: Identifiable, Codable, Sendable {
    public let id: String
    public let title: String
    public let description: String

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
    }
}

extension Recipe {
    enum CodingKeys: String, CodingKey {
        case title = "dynamicTitle"
        case description = "dynamicDescription"
    }
}
