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
            AsyncImageView(url: recipe.thumbnail.url, alt: recipe.thumbnail.alt)

            VStack(alignment: .leading, spacing: 4) {
                Text("Recipe")
                    .font(.caption.weight(.medium))
                    .textCase(.uppercase)
                    .foregroundStyle(.accent)

                Text(recipe.title)
                    .lineLimit(2)
                    .font(.body)
                    .fontDesign(.serif)
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
