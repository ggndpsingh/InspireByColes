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
                AsyncImageView(url: recipe.thumbnail.url)
                    .aspectRatio(480/280, contentMode: .fit)
                    .frame(minHeight: 240)

                VStack(alignment: .leading, spacing: 24) {
                    titleAndDescription

                    Divider()

                    HStack(spacing: 16) {
                        durationView(time: recipe.prepTime)
                        durationView(time: recipe.cookTime)
                        amountView
                    }

                    ingredientsView
                }
                .padding(.horizontal, 16)
            }
        }
        .ignoresSafeArea(edges: .top)
    }

    private var titleAndDescription: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Capsule().fill(.accent)
                    .frame(maxHeight: .infinity)
                    .frame(width: 4)

                Text(recipe.title)
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.leading)
            }

            Text(recipe.description)
        }
    }

    private var amountView: some View {
        VStack {
            Text(recipe.amount.amountType.title)
                .font(.footnote.weight(.bold))
            Text(recipe.amount.value, format: .number)
                .font(.callout)
        }
        .pill()
    }

    private func durationView(time: Recipe.Time) -> some View {
        VStack(spacing: 0) {
            Text(time.label)
                .font(.footnote.weight(.bold))

            Text(
                time.duration,
                format: .units(width: .wide, maximumUnitCount: 3)
            )
            .font(.callout)

            if let notes = time.note {
                Text(notes)
                    .font(.caption)
            }
        }
        .pill()
    }

    private var ingredientsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(recipe.ingredients.map(\.ingredient), id: \.self) { ingredient in
                HStack(alignment: .top, spacing: 8) {
                    Text("\u{2022}")
                    Text(ingredient)
                }
            }
        }
    }
}

struct PillViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(4)
            .background(.thinMaterial)
            .clipShape(.capsule)
            .overlay {
                Capsule().stroke(.quaternary, lineWidth: 1)
            }
    }
}

extension View {
    func pill() -> some View {
        modifier(PillViewModifier())
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
