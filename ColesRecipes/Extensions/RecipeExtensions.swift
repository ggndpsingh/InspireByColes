//
//  RecipeExtensions.swift
//  ColesRecipes
//

import Foundation
import ColesInspire

extension Recipe.Image {
    var url: URL {
        InspirationClient.baseURL.appending(path: path)
    }
}
