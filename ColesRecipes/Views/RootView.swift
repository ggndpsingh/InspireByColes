//
//  RootView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct RootView: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @Namespace private var namespace

    @State private var store = InspirationStore(client: InspirationClient())
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selectedRecipe: Recipe?
    @State private var searchText: String = ""

    private var bindableStore: Bindable<InspirationStore> { .init(store) }

    var body: some View {
        content
            .onViewDidLoad(store.fetchRecipes)
            .environment(store)
            .animation(.default, value: store.recipesDataState)
    }

    @ViewBuilder
    private var content: some View {
        switch horizontalSizeClass {
        case .regular:
            InspirationViewRegular(dataState: store.recipesDataState, selection: $selectedRecipe)
        default:
            InspirationViewCompact(dataState: store.recipesDataState, selection: $selectedRecipe)
        }
    }
}

#Preview {
    RootView()
        .environment(InspirationStore(client: InspirationClient()))
}
