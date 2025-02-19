//
//  InspirationStore.swift
//  ColesRecipes
//

import Foundation
import SwiftUI
import ColesInspire

@Observable
final class InspirationStore {

    private let client: InspirationProviding

    private(set) var recipesDataState: DataState<[Recipe]> = .loading

    init(client: InspirationProviding) {
        self.client = client
    }

    @Sendable
    func fetchRecipes() async {
        recipesDataState = .loading

        do {
            let recipes = try await client.findInspiration()
            recipesDataState = .success(recipes)
        } catch {
            recipesDataState = .failure(error)
        }
    }

    func imageURL(relativePath: String) -> URL {
        client.buildURL(relativePath: relativePath)
    }
}
