//
//  Recipe.swift
//  ColesInspire
//

import Foundation

public struct Recipe: Identifiable, Decodable, Sendable {
    public let id: String
    public let title: String
    public let description: String
    public let thumbnail: Recipe.Image
    public let amount: Amount
    public let prepTime: Time
    public let cookTime: Time
    public let ingredients: [Ingredient]

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)

        let thumbnailPath = try container.decode(String.self, forKey: .thumbnailPath)
        let thumbnailAlt = try container.decode(String.self, forKey: .thumbnailAlt)
        self.thumbnail = .init(path: thumbnailPath, alt: thumbnailAlt)

        let details = try container.nestedContainer(keyedBy: DetailsCodingKeys.self, forKey: .details)
        let amountLabel = try details.decode(String.self, forKey: .amountLabel)
        let amountNumber = try details.decode(Int.self, forKey: .amountNumber)
        self.amount = .init(amountLabel: amountLabel, value: amountNumber)

        let prepLabel = try details.decode(String.self, forKey: .prepLabel)
        let prepDuration = try details.decode(Int.self, forKey: .prepTimeAsMinutes)
        let prepNote = try details.decodeIfPresent(String.self, forKey: .prepNote)
        self.prepTime = .init(label: prepLabel, durationAsMinutes: prepDuration, note: prepNote)

        let cookLabel = try details.decode(String.self, forKey: .cookingLabel)
        let cookDuration = try details.decode(Int.self, forKey: .cookTimeAsMinutes)
        self.cookTime = .init(label: cookLabel, durationAsMinutes: cookDuration)

        self.ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
    }

    public init(
        id: String,
        title: String,
        description: String,
        thumbnail: Recipe.Image,
        amount: Amount,
        prepTime: Time,
        cookTime: Time,
        ingredients: [Ingredient]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
        self.amount = amount
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.ingredients = ingredients
    }
}

extension Recipe {
    enum CodingKeys: String, CodingKey {
        case title = "dynamicTitle"
        case description = "dynamicDescription"
        case thumbnailPath = "dynamicThumbnail"
        case thumbnailAlt = "dynamicThumbnailAlt"
        case details = "recipeDetails"
        case ingredients
    }

    enum DetailsCodingKeys: String, CodingKey {
        case amountLabel
        case amountNumber
        case prepLabel
        case prepNote
        case cookingLabel
        case cookTimeAsMinutes
        case prepTimeAsMinutes
    }
}
