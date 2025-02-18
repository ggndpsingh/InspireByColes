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

    private var columns: [GridItem] {
        switch horizontalSizeClass {
        case .regular:
            [GridItem(.adaptive(minimum: 240, maximum: 360))]
        default:
            [GridItem(.adaptive(minimum: 120, maximum: 240))]
        }
    }

    private var bindableStore: Bindable<InspirationStore> { .init(store) }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(store.recipes) { recipe in
                        RecipeCardView(recipe: recipe)
                    }
                }
                .padding()
            }
            .task(store.fetchRecipes)
        }
        .searchable(text: bindableStore.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Find what inspires you...")
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
