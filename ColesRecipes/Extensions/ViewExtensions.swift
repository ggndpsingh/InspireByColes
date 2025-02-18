//
//  ViewExtensions.swift
//  ColesRecipes
//

import SwiftUI

extension View {
    func readSize(_ value: Binding<CGSize>, skipRepeats: Bool = true) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear.preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self) { size in
            if size == value.wrappedValue && skipRepeats { return }
            value.wrappedValue = size
        }
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
