//
//  File.swift
//  ColesInspire
//

import Foundation

public protocol InspirationProviding: Sendable {
    func findInspiration() async throws -> [Recipe]
}
