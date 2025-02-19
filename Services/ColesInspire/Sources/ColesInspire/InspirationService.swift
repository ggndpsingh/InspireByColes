//
//  InspirationService.swift
//  ColesInspire
//

import Foundation

struct InspirationService {

    let apiEndpoint: APIEndpoint

    init(apiEndpoint: APIEndpoint) {
        self.apiEndpoint = apiEndpoint
    }

    /// Asynchronously fetches recipe inspiration data from a remote endpoint using a custom URL protocol.
    ///
    /// This method configures a URL session with an ephemeral configuration and a custom protocol class,
    /// then performs a GET request to retrieve the data from a specified URL.
    ///
    /// - Returns: A `Data` object containing the content retrieved from the endpoint.
    /// - Throws: An error if the data retrieval fails.
    func fetchInspirationRecipes() async throws -> Data {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [InspirationURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        let request = URLRequest(url: URL(string: "http://www.coles.com.au/content/dam/coles/inspire-create")!)
        let (data, _) = try await urlSession.data(for: request)

        // Mock loading state for a while.
        try? await Task.sleep(for: .seconds(1))
        return data
    }

    /// Constructs a complete image URL from the provided relative path.
    ///
    /// - Parameter relativePath: The relative path of the image received in the API payload.
    /// - Returns: A fully formed URL.
    public func buildURL(relativePath: String) -> URL {
        return apiEndpoint.baseURL.appending(path: relativePath)
    }
}

