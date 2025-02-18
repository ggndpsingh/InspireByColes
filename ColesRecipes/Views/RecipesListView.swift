//
//  RecipesListView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct RecipesListView: View {

    @Environment(InspirationStore.self) private var store
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let dataState: DataState<[Recipe]>
    @Binding var selection: Recipe?
    let namespace: Namespace.ID

    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 160, maximum: 360))]
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                switch dataState {
                case .loading:
                    redactedView
                case .success(let value):
                    content(recipes: value)
                case .failure:
                    Text("Failed")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(.inspireLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 8)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .refreshable {
            await store.fetchRecipes()
        }
    }

    private func content(recipes: [Recipe]) -> some View {
        ForEach(recipes) { recipe in
            RecipeCardView(recipe: recipe)
                .matchedTransitionSource(id: recipe.id, in: namespace)
                .onTapGesture {
                    selection = recipe
                }
        }
    }

    private var redactedView: some View {
        ForEach(Recipe.placeholders, id: \.title) { recipe in
            RecipeCardView(recipe: recipe)
                .redacted(reason: .placeholder)
        }
    }
}

#Preview("Loaded") {
    @Previewable @Namespace var namespace
    RecipesListView(dataState: .success(Recipe.placeholders), selection: .constant(nil), namespace: namespace)
}

#Preview("Loading") {
    @Previewable @Namespace var namespace
    RecipesListView(dataState: .loading, selection: .constant(nil), namespace: namespace)
}
