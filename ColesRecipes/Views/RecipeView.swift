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
                AsyncImageView(url: recipe.thumbnail.url, alt: recipe.thumbnail.alt)
                    .frame(minHeight: 240)

                VStack(alignment: .leading, spacing: 24) {
                    titleAndDescription

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 200))], alignment: .leading, spacing: 16) {
                        durationView(time: recipe.prepTime)
                        durationView(time: recipe.cookTime)
                        amountView
                    }
                    .contentTransition(.identity)
                    .compositingGroup()

                    Divider()
                        .padding(.horizontal, 48)

                    ingredientsView
                }
                .padding(.horizontal, 24)
            }
            .padding(.bottom, 48)
        }
        .ignoresSafeArea(edges: .top)
        .background(.background.secondary)
    }

    private var titleAndDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(recipe.title)
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(.leading)

            Text(recipe.description)
        }
        .fontDesign(.serif)
    }

    private var amountView: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 4) {
                Image(systemName: "person.2")
                    .imageScale(.large)
                    .foregroundStyle(.accent)

                VStack(alignment: .leading, spacing: 0) {
                    Text(recipe.amount.amountType.title)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)

                    Text(recipe.amount.value,format: .number)
                }
            }
        }
        .font(.footnote)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private func durationView(time: Recipe.Time) -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 4) {
                Image(systemName: "timer")
                    .imageScale(.large)
                    .foregroundStyle(.accent)

                VStack(alignment: .leading, spacing: 0) {
                    Text(time.label)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)

                    Text(
                        time.duration,
                        format: .units(width: .narrow, maximumUnitCount: 3)
                    )

                    if let notes = time.note {
                        Text(notes)
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .geometryGroup()
        .contentTransition(.identity)
        .font(.footnote)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private var ingredientsView: some View {
        VStack(spacing: 12) {
            Text("Ingredients:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 16) {
                ForEach(recipe.ingredients.map(\.ingredient), id: \.self) { ingredient in
                    Text(ingredient)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
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
}
