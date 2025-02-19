//
//  AsyncImageView.swift
//  ColesRecipes
//

import SwiftUI

struct AsyncImageView: View {

    let url: URL

    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            Placeholder()
        }
    }
}

private extension AsyncImageView {
    struct Placeholder: View {
        @State private var opacity: Double = 1.0

        var body: some View {
            Rectangle()
                .fill(Color.gray.opacity(opacity))
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        opacity = 0.5
                    }
                }
        }
    }
}
