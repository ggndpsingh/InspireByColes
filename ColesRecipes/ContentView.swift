//
//  ContentView.swift
//  ColesRecipes
//
//  Created by Gagandeep Singh on 18/2/2025.
//

import SwiftUI
import ColesInspire

struct ContentView: View {

    private let client = InspirationClient()

    @State private var recipes: [Recipe] = []

    var body: some View {
        List(recipes) { recipe in
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.title)
            }
        }
        .task {
            do {
                recipes = try await client.findInspiration()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
