//
//  InspirationViewCompact.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct InspirationViewCompact: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let recipes: [Recipe]
    @Namespace private var namespace

    @State private var selectedRecipe: Recipe?

    var body: some View {
        NavigationStack {
            RecipesListView(recipes: recipes, selection: $selectedRecipe, namespace: namespace)
        }
        .sheet(item: $selectedRecipe) { recipe in
            RecipeView(recipe: recipe)
                .navigationTransition(.zoom(sourceID: recipe.id, in: namespace))
        }
    }
}

#Preview {
    RootView()
        .environment(InspirationStore(client: InspirationClient()))
}
