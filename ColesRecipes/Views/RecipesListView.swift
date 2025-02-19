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
            switch dataState {
            case .loading:
                redactedView
            case .success(let value):
                content(recipes: value)
            case .failure(let error):
                EmptyStateView(error: error) {
                    Task {
                        await store.fetchRecipes()
                    }
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
        .refreshable {
            await store.fetchRecipes()
        }
    }

    private func content(recipes: [Recipe]) -> some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(recipes) { recipe in
                RecipeCardView(recipe: recipe)
                    .matchedTransitionSource(id: recipe.id, in: namespace)
                    .onTapGesture {
                        selection = recipe
                    }
            }
        }
        .padding()
    }

    private var redactedView: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(Recipe.mocks, id: \.title) { recipe in
                RecipeCardView(recipe: recipe)
                    .redacted(reason: .placeholder)
            }
        }
        .padding()
    }
}

#Preview("Loaded") {
    @Previewable @Namespace var namespace
    RecipesListView(dataState: .success(Recipe.mocks), selection: .constant(nil), namespace: namespace)
        .environment(InspirationStore(client: MockInspirationClient()))
}

#Preview("Loading") {
    @Previewable @Namespace var namespace
    RecipesListView(dataState: .loading, selection: .constant(nil), namespace: namespace)
        .environment(InspirationStore(client: MockInspirationClient()))
}


#Preview("Failed") {
    @Previewable @Namespace var namespace
    RecipesListView(dataState: .failure(URLError(.badServerResponse)), selection: .constant(nil), namespace: namespace)
        .environment(InspirationStore(client: MockInspirationClient()))
}
