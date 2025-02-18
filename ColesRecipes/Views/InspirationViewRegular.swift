//
//  InspirationViewRegular.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct InspirationViewRegular: View {

    let dataState: DataState<[Recipe]>
    @Namespace private var namespace

    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @Binding var selection: Recipe?

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            RecipesListView(dataState: dataState, selection: $selection, namespace: namespace)
        } detail: {
            if let selection {
                RecipeView(recipe: selection)
                    .toolbarVisibility(columnVisibility == .detailOnly ? .visible : .hidden, for: .navigationBar)
            }
        }
        .navigationSplitViewStyle(.balanced)
        .animation(.snappy, value: selection)
        .onChange(of: dataState.value, recipesDidChange)
        .onAppear {
            if selection == nil {
                selection = dataState.value?.first
            }
        }
    }

    private func recipesDidChange(oldValue: [Recipe]?, newValue: [Recipe]?) {
        if oldValue == nil, newValue != nil {
            selection = newValue?.first
        }
    }
}

#Preview {
    RootView()
        .environment(InspirationStore(client: InspirationClient()))
}
