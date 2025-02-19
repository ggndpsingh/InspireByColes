//
//  RecipeCardView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct RecipeCardView: View {

    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                AsyncImageView(path: recipe.thumbnail.path, alt: recipe.thumbnail.alt)
                    .aspectRatio(480/288, contentMode: .fit)
                detailsView
            }

            Text(recipe.title)
                .lineLimit(2)
                .font(.body)
                .fontDesign(.serif)
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

    private var detailsView: some View {
        HStack(spacing: 12) {
            DurationLabelView(time: recipe.totalTime, scale: .s)
        }
        .padding(4)
        .background {
            Capsule().fill(.thinMaterial)
        }
        .padding(4)
    }
}

#Preview {
    RecipeCardView(recipe: .mock)
        .padding()
}
