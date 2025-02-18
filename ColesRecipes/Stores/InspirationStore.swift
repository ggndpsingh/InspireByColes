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

    private(set) var recipes: [Recipe] = []

    init(client: InspirationProviding) {
        self.client = client
    }

    @Sendable
    func fetchRecipes() async {
        do {
            recipes =  try await client.findInspiration()
        } catch {
            print(error)
        }
    }
}
