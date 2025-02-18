//
//  ColesRecipesApp.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

@main
struct ColesRecipesApp: App {
    @State private var store = InspirationStore(client: InspirationClient())

    var body: some Scene {
        WindowGroup {
            InspirationView()
                .environment(store)
        }
    }
}
