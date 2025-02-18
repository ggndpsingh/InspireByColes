//
//  InspirationStore.swift
//  ColesRecipes
//

import Foundation
import SwiftUI
import ColesInspire

@Observable
final class InspirationStore {

    let client: InspirationProviding

    init(client: InspirationProviding) {
        self.client = client
    }

    private(set) var recipes: [Recipe] = []

    @Sendable
    func fetchRecipes() async {
        do {
            recipes =  try await client.findInspiration()
        } catch {
            print(error)
        }
    }
}
