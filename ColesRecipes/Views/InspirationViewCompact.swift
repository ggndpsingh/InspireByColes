//
//  InspirationViewCompact.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct InspirationViewCompact: View {

    let dataState: DataState<[Recipe]>
    @Namespace private var namespace

    @Binding var selection: Recipe?

    var body: some View {
        NavigationStack {
            RecipesListView(dataState: dataState, selection: $selection, namespace: namespace)
        }
        .sheet(item: $selection) { recipe in
            RecipeView(recipe: recipe)
                .navigationTransition(.zoom(sourceID: recipe.id, in: namespace))
        }
    }
}

#Preview {
    RootView()
        .environment(InspirationStore(client: InspirationClient()))
}
