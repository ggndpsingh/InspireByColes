// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class InspirationClient: InspirationProviding {
    public static let baseURL: URL = .init(string: "https://www.coles.com.au")!

    private let service = InspirationService()

    public init() {}

    public func findInspiration() async throws -> [Recipe] {
        let data = try await service.fetchInspirationRecipes()
        let decoder = JSONDecoder()
        let response = try decoder.decode(InspirationResponse.self, from: data)
        return response.recipes
    }
}
