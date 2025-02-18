//
//  Amount.swift
//  ColesInspire
//

import Foundation

public extension Recipe {
    struct Amount: Decodable, Sendable {
        public let amountType: AmountType
        public let value: Int

        init(amountLabel: String, value: Int) {
            self.amountType = .init(rawValue: amountLabel) ?? .serves
            self.value = value
        }

        public enum AmountType: String, Decodable, Sendable  {
            case serves = "Serves"
        }
    }
}
