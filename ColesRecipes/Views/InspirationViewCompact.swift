//
//  InspirationViewCompact.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct InspirationViewCompact: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let dataState: DataState<[Recipe]>
    @Namespace private var namespace

    @Binding var selection: Recipe?

    private var navigationPath: Binding<[Recipe]> {
        .init(
            get: {
                guard let selection else { return [] }
                return [selection]
            },
            set: {
                selection = $0.first
            }
        )
    }

    var body: some View {
        NavigationStack(path: navigationPath) {
            RecipesListView(dataState: dataState, selection: $selection, namespace: namespace)
                .navigationDestination(for: Recipe.self) { recipe in
                    RecipeView(recipe: recipe)
                        .navigationTransition(.zoom(sourceID: recipe.id, in: namespace))
                }
        }
    }
}

#Preview {
    RootView(client: MockInspirationClient())
}
