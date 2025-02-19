//
//  RecipeExtensions.swift
//  ColesRecipes
//

import Foundation
import ColesInspire

extension Recipe.Image {
    var url: URL {
        InspirationClient.baseURL.appending(path: path)
    }
}

extension Recipe {
    static var mock: Recipe {
        .init(
            id: UUID().uuidString,
            title: "Apple and kale panzanella",
            description: "For a wintery spin on a classic dish, try this fresh panzanella salad. It’s bursting with vibrant veggies and zesty flavour.",
            thumbnail: .init(
                path: "/content/dam/coles/inspire-create/thumbnails/Panzanella-salad-480x280.jpg",
                alt: "Roasted carrots, radish, pear, kale and herbs served on a plate"
            ),
            amount: .init(amountType: .serves, value: 4),
            prepTime: .init(label: "Prep", durationAsMinutes: 20, note: "+ cooling time"),
            cookTime: .init(label: "Cooking", durationAsMinutes: 30),
            ingredients: [
                .init(ingredient: "2 bunches Dutch carrots, trimmed"),
                .init(ingredient: "2/3 cup (160ml) olive oil"),
                .init(ingredient: "1/2 Coles Finest by Laurent White Sourdough Vienna, day-old, cut into 4cm pieces"),
                .init(ingredient: "1/4 cup (20g) finely grated parmesan"),
                .init(ingredient: "1/2 lemon, rind finely grated, juiced"),
                .init(ingredient: "2 garlic cloves, finely chopped"),
                .init(ingredient: "1/2 cup (125ml) buttermilk"),
                .init(ingredient: "1 1/2 tbsp apple cider vinegar"),
                .init(ingredient: "1/2 bunch kale, leaves coarsely torn"),
                .init(ingredient: "1/2 cup mint leaves"),
                .init(ingredient: "1/2 cup flat-leaf parsley leaves"),
                .init(ingredient: "2 apples, thinly sliced"),
                .init(ingredient: "2 spring onions, thinly sliced"),
                .init(ingredient: "1/4 cup (50g) pepitas (pumpkin seeds), toasted")
            ]
        )
    }
}

extension Recipe {
    static var placeholders: [Recipe] = [.placeholder1, .placeholder2, .placeholder3, .placeholder4, .placeholder5]

    static var placeholder1: Recipe {
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

    static var placeholder2: Recipe {
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

    static var placeholder3: Recipe {
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

    static var placeholder4: Recipe {
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

    static var placeholder5: Recipe {
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
