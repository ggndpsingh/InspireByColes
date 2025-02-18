//
//  Amount.swift
//  ColesInspire
//

import Foundation

public extension Recipe {
    struct Amount: Decodable, Sendable, Equatable {
        public let amountType: AmountType
        public let value: Int

        public init(amountType: AmountType, value: Int) {
            self.amountType = amountType
            self.value = value
        }
    }
}

public extension Recipe.Amount {
    enum AmountType: String, Decodable, Sendable, Equatable  {
        case serves = "Serves"
    }
}

extension Recipe.Amount {
    init(amountLabel: String, value: Int) {
        self.init(amountType: .init(rawValue: amountLabel) ?? .serves, value: value)
    }
}
