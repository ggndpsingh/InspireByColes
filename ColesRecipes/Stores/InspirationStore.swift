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

    private var allRecipes: [Recipe] = []

    var searchText: String = ""

    init(client: InspirationProviding) {
        self.client = client
    }

    var recipes: [Recipe] {
        if !searchText.isEmpty {
            return allRecipes.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        return allRecipes
    }

    @Sendable
    func fetchRecipes() async {
        do {
            allRecipes =  try await client.findInspiration()
        } catch {
            print(error)
        }
    }
}
