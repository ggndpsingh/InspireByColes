//
//  ViewExtensions.swift
//  ColesRecipes
//

import SwiftUI

private struct ViewDidLoadModifier: ViewModifier {

    @State private var isViewLoaded = false
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                if !isViewLoaded {
                    action()
                }

                isViewLoaded = true
            }
    }
}

extension View {

    public func onViewDidLoad(_ action: @escaping () -> Void) -> some View {
        modifier(ViewDidLoadModifier(action: action))
    }

    public func onViewDidLoad(_ action: @escaping () async -> Void) -> some View {
        modifier(ViewDidLoadModifier(action: {
            Task {
                await action()
            }
        }))
    }
}
