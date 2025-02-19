//
//  File.swift
//  ColesInspire
//

import Foundation

public protocol InspirationProviding: Sendable {

    /// Asynchronously retrieves an array of recipe inspirations.
    ///
    /// - Returns: An array of `Recipe` objects.
    /// - Throws: An error if fetching or decoding the recipes fails.
    func findInspiration() async throws -> [Recipe]

    /// Constructs a complete image URL from the provided relative path.
    ///
    /// - Parameter relativePath: The relative path of the image received in the API payload.
    /// - Returns: A fully formed URL.
    func buildURL(relativePath: String) -> URL
}
