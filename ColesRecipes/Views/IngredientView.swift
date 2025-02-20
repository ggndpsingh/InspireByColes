//
//  IngredientView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct IngredientView: View {
    let ingredient: Ingredient

    var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityElement(children: .combine)
            .accessibilityLabel(ingredient.label)
    }

    private var content: some View {
        HStack(alignment: .top) {
            Text("•")

            Text(ingredient.item)
                .fontWeight(.semibold)

            +

            Text(" " + ingredient.notes)
                .foregroundStyle(.secondary)
        }
        .contentTransition(.opacity)
        .fontDesign(.serif)
    }
}

#Preview {
    IngredientView(ingredient: Recipe.mock.ingredients[0])
        .padding()
}
