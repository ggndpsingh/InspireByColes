//
//  RecipesListView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct RecipesListView: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let recipes: [Recipe]
    @Binding var selection: Recipe?
    let namespace: Namespace.ID

    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 160, maximum: 360))]
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(removing: .sidebarToggle)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(.inspireLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 8)
            }
        }
        .animation(.default, value: recipes)
    }
}

#Preview {
    @Previewable @Namespace var namespace
    RecipesListView(recipes: [.mock], selection: .constant(nil), namespace: namespace)
}
