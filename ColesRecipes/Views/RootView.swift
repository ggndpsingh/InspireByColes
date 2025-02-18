//
//  RootView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct RootView: View {

    @State private var store = InspirationStore(client: InspirationClient())

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @Namespace private var namespace

    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selectedRecipe: Recipe?

    private var bindableStore: Bindable<InspirationStore> { .init(store) }

    var body: some View {
        content
            .task(store.fetchRecipes)
            .environment(store)
            .animation(.default, value: store.recipes)
            .searchable(text: bindableStore.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Find what inspires you...")
    }

    @ViewBuilder
    private var content: some View {
        switch horizontalSizeClass {
        case .regular:
            InspirationViewRegular(recipes: store.recipes)
        default:
            InspirationViewCompact(recipes: store.recipes)
        }
    }
}

#Preview {
    RootView()
        .environment(InspirationStore(client: InspirationClient()))
}
