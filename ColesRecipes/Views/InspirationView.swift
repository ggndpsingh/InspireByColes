//
//  InspirationView.swift
//  ColesRecipes
//
//  Created by Gagandeep Singh on 18/2/2025.
//

import SwiftUI
import ColesInspire

struct InspirationView: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(InspirationStore.self) private var store

    @Namespace private var namespace

    @State private var selectedRecipe: Recipe?

    private var columns: [GridItem] {
        switch horizontalSizeClass {
        case .regular:
            [GridItem(.adaptive(minimum: 240, maximum: 360))]
        default:
            [GridItem(.adaptive(minimum: 160, maximum: 240))]
        }
    }

    private var bindableStore: Bindable<InspirationStore> { .init(store) }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(store.recipes) { recipe in
                        RecipeCardView(recipe: recipe)
                            .matchedTransitionSource(id: recipe.id, in: namespace)
                            .onTapGesture {
                                selectedRecipe = recipe
                            }
                    }
                }
                .padding()
            }
            .task(store.fetchRecipes)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.inspireLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 8)
                }
            }
        }
        .animation(.default, value: store.recipes)
        .searchable(text: bindableStore.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Find what inspires you...")
        .sheet(item: $selectedRecipe) { recipe in
            RecipeView(recipe: recipe)
                .navigationTransition(.zoom(sourceID: recipe.id, in: namespace))
        }
    }
}

extension Recipe.Image {
    var url: URL {
        InspirationClient.baseURL.appending(path: path)
    }
}

#Preview {
    InspirationView()
        .environment(InspirationStore(client: InspirationClient()))
}
