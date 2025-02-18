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
                AsyncImageView(url: recipe.thumbnail.url)
                    .aspectRatio(480/280, contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 12, style: .continuous))
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

extension Recipe.Image {
    var url: URL {
        InspirationClient.baseURL.appending(path: path)
    }
}

#Preview {
    ContentView()
}
