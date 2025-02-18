//
//  File.swift
//  ColesInspire
//
//  Created by Gagandeep Singh on 18/2/2025.
//

import Foundation

public protocol InspirationProviding: Sendable {
    func findInspiration() async throws -> [Recipe]
}
