//
//  ColesRecipesUITests.swift
//  ColesRecipesUITests
//

import XCTest

final class ColesRecipesUITests: XCTestCase {

    private let app = XCUIApplication()

    @MainActor
    func testCardIsLoadedAndIsTappable() throws {
        app.launch()

        XCTAssertTrue(cardImage.waitForExistence(timeout: 5))
        XCTAssertTrue(cardTitle.exists)
        try recipeIsPresented()
    }

    func recipeIsPresented() throws {
        cardImage.tap()
        XCTAssertTrue(recipeScrollView.waitForExistence(timeout: 2))
        recipeScrollView.swipeUp()
        XCTAssert(recipeTitle.exists)
        XCTAssert(recipeDescription.exists)
        XCTAssert(recipeIngredients.exists)
    }

    private var cardImage: XCUIElement {
        app.images[AccessibilityIdentifiers.List.Card.image].firstMatch
    }

    private var cardTitle: XCUIElement {
        app.staticTexts[AccessibilityIdentifiers.List.Card.title].firstMatch
    }

    private var recipeScrollView: XCUIElement {
        app.scrollViews[AccessibilityIdentifiers.Recipe.scrollView]
    }

    private var recipeTitle: XCUIElement {
        app.staticTexts[AccessibilityIdentifiers.Recipe.title]
    }

    private var recipeDescription: XCUIElement {
        app.staticTexts[AccessibilityIdentifiers.Recipe.description]
    }

    private var recipeIngredients: XCUIElement {
        app.staticTexts[AccessibilityIdentifiers.Recipe.ingredients]
    }
}
