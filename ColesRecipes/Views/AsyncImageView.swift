//
//  AsyncImageView.swift
//  ColesRecipes
//

import SwiftUI

struct AsyncImageView: View {

    private let cache = ImageCache()
    let url: URL
    let alt: String

    @State private var dataState: DataState<UIImage> = .loading

    var body: some View {
        content
            .aspectRatio(480/288, contentMode: .fit)
            .task(loadImage)
            .onChange(of: url) {
                Task {
                    await loadImage()
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        switch dataState {
        case .loading:
            Color.gray
                .redacted(reason: .placeholder)
        case .success(let value):
            Image(uiImage: value)
                .resizable()
                .accessibilityLabel(Text(alt))
                .id(url)

        case .failure:
            ZStack {
                Color.gray.opacity(0.8)
                Image(systemName: "photo")
                    .imageScale(.large)
                    .foregroundStyle(.background)
            }
        }
    }

    @Sendable
    private func loadImage() async {
        if let cachedImage = cache[url] {
            dataState = .success(cachedImage)
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                dataState = .success(image)
            } else {
                dataState = .failure(URLError(.badURL))
            }
        } catch {
            dataState = .failure(error)
        }
    }
}

private final class ImageCache {
    let cache: NSCache<NSURL, UIImage> = NSCache()

    subscript (url: URL) -> UIImage? {
        get { image(for: url) }
        set { store(newValue, for: url) }
    }

    private func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    private func store(_ image: UIImage?, for url: URL) {
        guard let image else { return }
        cache.setObject(image, forKey: url as NSURL)
    }
}
