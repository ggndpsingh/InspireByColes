//
//  DataState.swift
//  ColesRecipes
//

import Foundation

enum DataState<Value> {
    case loading
    case success(Value)
    case failure(Error)

    var value: Value? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}

extension DataState: Equatable where Value: Equatable {
    static func == (lhs: DataState<Value>, rhs: DataState<Value>) -> Bool {
        lhs.value == rhs.value &&
        lhs.error?.localizedDescription == rhs.error?.localizedDescription &&
        lhs.isLoading == rhs.isLoading
    }
}
