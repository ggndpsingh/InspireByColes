import Foundation
import Testing
@testable import ColesInspire

@Test func decodingRecipe() async throws {
    let response = """
    {
        "dynamicTitle": "Butter Chicken",
        "dynamicDescription": "One of the most popular curries in the world.",
        "dynamicThumbnail": "/content/dam/coles/inspire-create/thumbnails/Tomato-and-bread-salad-480x288.jpg",
        "dynamicThumbnailAlt": "",
        "recipeDetails": {
            "amountLabel": "Serves",
            "amountNumber": 6,
            "prepLabel": "Prep",
            "prepTime": "25m",
            "prepNote": "+ soaking time",
            "cookingLabel": "Cooking",
            "cookingTime": "45m",
            "cookTimeAsMinutes": 45,
            "prepTimeAsMinutes": 25
        },
        "ingredients": [
            {
                "ingredient": "1 cup (250ml) extra virgin olive oil, divided"
            },
            {
                "ingredient": "4 cups (240g) 2cm-pieces day-old Coles Bakery Stone Baked by Laurent Pane Di Casa"
            }
        ]
    }
    """

    let data = response.data(using: .utf8)!
    let recipe = try JSONDecoder().decode(Recipe.self, from: data)
    #expect(recipe.title == "Butter Chicken")
    #expect(recipe.amount == .init(amountType: .serves, value: 6))
    #expect(recipe.prepTime == .init(label: "Prep", durationAsMinutes: 25, note: "+ soaking time"))
    #expect(recipe.cookTime == .init(label: "Cooking", durationAsMinutes: 45))
    #expect(recipe.totalTime.duration == .seconds(70 * 60))
}
