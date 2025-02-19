//
//  RecipeView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct RecipeView: View {

    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                StretchableHeader {
                    AsyncImageView(path: recipe.thumbnail.path, alt: recipe.thumbnail.alt)
                }
                .aspectRatio(480/288, contentMode: .fill)

                VStack(alignment: .leading, spacing: 24) {
                    titleAndDescription

                    detailsView

                    Divider()
                        .padding(.horizontal, 48)

                    ingredientsView
                }
                .padding(.horizontal, 24)
            }
            .padding(.bottom, 48)
        }
        .accessibilityIdentifier(AccessibilityIdentifiers.Recipe.scrollView)
        .ignoresSafeArea(edges: .top)
        .background(.background.secondary)
    }

    private var titleAndDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(recipe.title)
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(.leading)
                .accessibilityIdentifier(AccessibilityIdentifiers.Recipe.title)

            Text(recipe.description)
                .accessibilityIdentifier(AccessibilityIdentifiers.Recipe.description)
        }
        .fontDesign(.serif)
    }

    private var detailsView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 200))], alignment: .leading, spacing: 16) {
            DurationLabelView(time: recipe.prepTime)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            DurationLabelView(time: recipe.cookTime)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            AmountLabelView(amount: recipe.amount, scale: .l)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .contentTransition(.identity)
        .compositingGroup()
    }

    private var ingredientsView: some View {
        VStack(spacing: 12) {
            Text("Ingredients")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
                .accessibilityIdentifier(AccessibilityIdentifiers.Recipe.ingredients)

            VStack(alignment: .leading, spacing: 16) {
                ForEach(recipe.ingredients, id: \.self, content: IngredientView.init)
            }
            .contentTransition(.opacity)
            .fontDesign(.serif)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension Recipe.Amount.AmountType {
    var title: String {
        switch self {
        case .serves: "Serves"
        }
    }
}

#Preview {
    RecipeView(recipe: .mock)
        .environment(InspirationStore(client: MockInspirationClient()))
}
