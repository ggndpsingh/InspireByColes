//
//  ColesRecipesTests.swift
//  ColesRecipesTests
//

import Testing
import XCTest
@testable import ColesRecipes

struct InspirationStoreTests {

    @Test func testDataStateSuccess() async throws {
        let client = MockInspirationClient(state: .populated)
        let store = InspirationStore(client: client)

        await store.fetchRecipes()

        switch store.recipesDataState {
        case .loading:
            Issue.record("The store should not still be loading.")
        case .failure:
            Issue.record("Unexpectedly found error.")
        case .success(let recipes):
            #expect(!recipes.isEmpty)
        }
    }

    @Test func testDataStateFailure() async throws {
        let client = MockInspirationClient(state: .error)
        let store = InspirationStore(client: client)

        await store.fetchRecipes()

        switch store.recipesDataState {
        case .loading:
            Issue.record("The store should not still be loading.")
        case .failure(let error):
            #expect(error.localizedDescription == URLError(.badServerResponse).localizedDescription)
        case .success(let recipes):
            Issue.record("Unexpectedly returned recipes when an error is expected: \(recipes).")
        }
    }
}
