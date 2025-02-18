//
//  StretchableHeaderView.swift
//  ColesRecipes
//

import SwiftUI

struct StretchableHeader<Content: View>: View {
    @ViewBuilder let content: () -> Content
    @State private var size: CGSize = .zero

    private var aspectRatio: CGFloat { size.width / size.height }

    var body: some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY

            content()
                .offset(
                    x: minY > 0 ? -(minY * aspectRatio) / 2 : 0,
                    y: minY > 0 ? -minY : 0
                )
                .frame(
                    width: minY > 0 ? size.width + (minY * aspectRatio) : size.width,
                    height: minY > 0 ? size.height + minY : size.height
                )
                .aspectRatio(aspectRatio, contentMode: .fill)
        }
        .readSize($size)
    }
}
