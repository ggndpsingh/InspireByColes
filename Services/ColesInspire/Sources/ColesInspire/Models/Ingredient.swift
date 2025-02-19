//
//  Ingredient.swift
//  ColesInspire
//

import Foundation

public struct Ingredient: Sendable, Equatable, Hashable {
    public let item: String
    public let notes: String
    public let label: String

    public init(ingredient: String) {
        var components = ingredient.split(separator: ", ")
        self.item = String(components.removeFirst())
        self.label = ingredient
        self.notes = components.map(String.init).joined(separator: ", ")
    }
}

extension Ingredient: Decodable {

    private enum CodingKeys: CodingKey {
        case ingredient
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let ingredient = try container.decode(String.self, forKey: .ingredient)
        self.init(ingredient: ingredient)
    }
}
