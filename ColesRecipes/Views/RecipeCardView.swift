//
//  RecipeCardView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct RecipeCardView: View {

    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImageView(url: recipe.thumbnail.url)
                .aspectRatio(480/280, contentMode: .fit)

            VStack(alignment: .leading, spacing: 4) {
                Text("Recipe")
                    .font(.footnote.weight(.medium))
                    .textCase(.uppercase)
                    .foregroundStyle(.accent)

                Text(recipe.title)
                    .lineLimit(2)
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.background.secondary)
        .clipShape(.rect(cornerRadius: 16, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.quaternary, lineWidth: 1)
        }
    }
}

#Preview {
    RecipeCardView(recipe: .mock)
        .padding()
}

#if DEBUG
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
#endif
