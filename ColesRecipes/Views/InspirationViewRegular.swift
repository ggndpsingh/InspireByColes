//
//  InspirationViewRegular.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct InspirationViewRegular: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let recipes: [Recipe]
    @Namespace private var namespace

    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selectedRecipe: Recipe?

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            RecipesListView(recipes: recipes, selection: $selectedRecipe, namespace: namespace)
        } detail: {
            if let selectedRecipe {
                RecipeView(recipe: selectedRecipe)
            }
        }
        .navigationSplitViewStyle(.balanced)
        .animation(.snappy, value: selectedRecipe)
        .onChange(of: recipes, recipesDidChange)
    }

    private func recipesDidChange(oldValue: [Recipe], newValue: [Recipe]) {
        if oldValue.isEmpty, !newValue.isEmpty {
            selectedRecipe = newValue.first
        }
    }
}

#Preview {
    RootView()
        .environment(InspirationStore(client: InspirationClient()))
}
