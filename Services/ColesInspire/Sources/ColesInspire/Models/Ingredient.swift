//
//  Ingredient.swift
//  ColesInspire
//

import Foundation

public struct Ingredient: Decodable, Sendable {
    let ingredient: String

    public init(ingredient: String) {
        self.ingredient = ingredient
    }
}
