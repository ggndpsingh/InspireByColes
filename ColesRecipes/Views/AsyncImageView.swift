//
//  AsyncImageView.swift
//  ColesRecipes
//

import SwiftUI

struct AsyncImageView: View {

    let url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
            } else if phase.error != nil {
                ZStack {
                    Color.gray.opacity(0.8)
                    Image(systemName: "photo")
                        .imageScale(.large)
                        .foregroundStyle(.background)
                }
            } else {
                Placeholder()
            }
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
