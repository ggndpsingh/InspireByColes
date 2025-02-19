// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// A client responsible for fetching recipe inspirations from the API.
/// This client provides pre-configured instances for both production and staging environments.
public final class InspirationClient: InspirationProviding {

    /// A pre-configured client instance for the production API endpoint.
    public static let production = InspirationClient(service: .init(apiEndpoint: .production))

    private let service: InspirationService

    private init(service: InspirationService) {
        self.service = service
    }

    /// Fetches recipe inspirations asynchronously.
    ///
    /// This method retrieves the recipe data from the associated service,
    ///
    /// - Returns: An array of `Recipe` instances.
    /// - Throws: An error if the network request fails or if the response cannot be decoded.
    public func findInspiration() async throws -> [Recipe] {
        let data = try await service.fetchInspirationRecipes()
        let decoder = JSONDecoder()
        let response = try decoder.decode(InspirationResponse.self, from: data)
        return response.recipes
    }
}

extension InspirationClient {

    /// Constructs a full URL from the provided relative path.
    ///
    /// - Parameter relativePath: The relative path.
    /// - Returns: A complete URL.
    ///
    /// **Note:** Ideally, the API payload would include complete URLs. However, since it only provides a relative path,
    /// this approach is necessary. This method keeps the details private to shield it from public exposure.
    public func buildURL(relativePath: String) -> URL {
        return service.buildURL(relativePath: relativePath)
    }
}
