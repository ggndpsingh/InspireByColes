//
//  Ingredient.swift
//  ColesInspire
//

import Foundation

public struct Ingredient: Decodable, Sendable, Equatable, Hashable {
    public let ingredient: String

    public init(ingredient: String) {
        self.ingredient = ingredient
    }
}
