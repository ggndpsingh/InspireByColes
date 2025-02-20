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

    func readRect(_ value: Binding<CGRect>, coordinateSpace: CoordinateSpace = .global, skipRepeats: Bool = true) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear.preference(key: RectPreferenceKey.self, value: geometryProxy.frame(in: coordinateSpace))
            }
        )
        .onPreferenceChange(RectPreferenceKey.self) { rect in
            if rect == value.wrappedValue && skipRepeats { return }
            value.wrappedValue = rect
        }
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


private struct RectPreferenceKey: PreferenceKey {
    static let defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}
