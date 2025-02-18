//
//  InspirationURLProtocol.swift
//  ColesInspire
//

import Foundation

/// A mock URL protocol that intercepts network requests and returns a predefined response based on a local JSON file.
final class InspirationURLProtocol: URLProtocol {

    /// A request handler closure that simulates a server response by retrieving data from a local "recipes.json" file.
    nonisolated(unsafe) static let requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data)) = { request in
        var statusCode: Int
        var data: Data

        if let url = Bundle.module.url(forResource: "recipes", withExtension: "json") {
            do {
                data = try Data(contentsOf: url)
                statusCode = 200
            } catch {
                data = "Bad Server Response".data(using: .utf8)!
                statusCode = URLError.badServerResponse.rawValue
            }
        } else {
            data = "Bad Server Response".data(using: .utf8)!
            statusCode = URLError.badServerResponse.rawValue
        }

        let response = HTTPURLResponse(
            url: URL(string: "http://www.coles.com.au/content/dam/coles/inspire-create")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )!

        return (response, data)
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        do {
            let (response, data) = try Self.requestHandler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
    }
}
