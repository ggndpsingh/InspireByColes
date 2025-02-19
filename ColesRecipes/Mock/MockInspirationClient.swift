//
//  MockInspirationClient.swift
//  ColesRecipes
//

import Foundation
import ColesInspire

final class MockInspirationClient: InspirationProviding {

    enum State {
        case populated
        case error
    }

    let state: State

    init(state: State = .populated) {
        self.state = state
    }

    func findInspiration() async throws -> [Recipe] {
        switch state {
        case .populated:
            return Recipe.mocks
        case .error:
            print("throwing")
            throw URLError(.badServerResponse)
        }
    }
}

extension Recipe {
    static var mocks: [Recipe] = [mock, .mock1, .mock2, .mock3, .mock4,]

    static var mock: Recipe {
        .init(
            id: "1",
            title: "Apple and kale panzanella",
            description: "For a wintery spin on a classic dish, try this fresh panzanella salad. It’s bursting with vibrant veggies and zesty flavour.",
            thumbnail: .init(
                path: "/content/dam/coles/inspire-create/thumbnails/Panzanella-salad-480x280.jpg",
                alt: "Roasted carrots, radish, pear, kale and herbs served on a plate"
            ),
            amount: .init(amountType: .serves, value: 4),
            prepTime: .init(label: "Prep", durationAsMinutes: 20, note: "+ cooling time"),
            cookTime: .init(label: "Cooking", durationAsMinutes: 30),
            ingredients: []
        )
    }

    static var mock1: Recipe {
        .init(
            id: "2",
            title: "Spicy Thai Noodles",
            description: "Experience the perfect balance of spicy and savory with these Thai noodles, tossed in a tangy sauce.",
            thumbnail: .init(
                path: "/content/dam/coles/inspire-create/thumbnails/Thai-noodles-480x280.jpg",
                alt: "Spicy Thai noodles garnished with basil and lime wedges"
            ),
            amount: .init(amountType: .serves, value: 2),
            prepTime: .init(label: "Prep", durationAsMinutes: 15, note: "+ marination time"),
            cookTime: .init(label: "Cooking", durationAsMinutes: 25),
            ingredients: []
        )
    }

    static var mock2: Recipe {
        .init(
            id: "3",
            title: "Mediterranean Quinoa Salad",
            description: "A refreshing mix of quinoa, cucumbers, olives, and feta cheese, perfect for a light and healthy meal.",
            thumbnail: .init(
                path: "/content/dam/coles/inspire-create/thumbnails/Quinoa-salad-480x280.jpg",
                alt: "Colorful Mediterranean quinoa salad with fresh veggies"
            ),
            amount: .init(amountType: .serves, value: 3),
            prepTime: .init(label: "Prep", durationAsMinutes: 10, note: "+ dressing preparation"),
            cookTime: .init(label: "Cooking", durationAsMinutes: 0),
            ingredients: []
        )
    }

    static var mock3: Recipe {
        .init(
            id: "4",
            title: "Grilled Chicken with Lemon Herb Sauce",
            description: "Juicy grilled chicken paired with a tangy lemon herb sauce, ideal for a healthy dinner.",
            thumbnail: .init(
                path: "/content/dam/coles/inspire-create/thumbnails/Grilled-chicken-480x280.jpg",
                alt: "Grilled chicken served with lemon slices and fresh herbs"
            ),
            amount: .init(amountType: .serves, value: 4),
            prepTime: .init(label: "Prep", durationAsMinutes: 15, note: "+ marination time"),
            cookTime: .init(label: "Cooking", durationAsMinutes: 35),
            ingredients: []
        )
    }

    static var mock4: Recipe {
        .init(
            id: "5",
            title: "Vegan Lentil Soup",
            description: "Hearty and warming vegan lentil soup packed with nutrients, perfect for chilly days.",
            thumbnail: .init(
                path: "/content/dam/coles/inspire-create/thumbnails/Vegan-lentil-soup-480x280.jpg",
                alt: "A bowl of vegan lentil soup garnished with fresh herbs"
            ),
            amount: .init(amountType: .serves, value: 6),
            prepTime: .init(label: "Prep", durationAsMinutes: 10, note: "+ soaking lentils"),
            cookTime: .init(label: "Cooking", durationAsMinutes: 40),
            ingredients: []
        )
    }
}
