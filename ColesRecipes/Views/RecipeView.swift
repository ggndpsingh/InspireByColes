//
//  RecipeView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct RecipeView: View {

    @Environment(\.dismiss) private var dismiss

    let recipe: Recipe
    @State private var titleRect: CGRect = .zero
    @State private var navigationTitleOpacity: Double = 0.0

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    StretchableHeader {
                        AsyncImageView(path: recipe.thumbnail.path, alt: recipe.thumbnail.alt)
                    }
                    .aspectRatio(480/288, contentMode: .fill)

                    VStack(alignment: .leading, spacing: 24) {
                        titleAndDescription

                        detailsView

                        Divider()
                            .padding(.horizontal, 48)

                        ingredientsView
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.bottom, 48)
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Text(recipe.title)
                        .fontWeight(.semibold)
                        .fontDesign(.serif)
                        .opacity(navigationTitleOpacity)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.gray)
                            .background(.white)
                            .clipShape(Circle())
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea(edges: .top)
            .accessibilityIdentifier(AccessibilityIdentifiers.Recipe.scrollView)
            .background(.background.secondary)
            .onChange(of: titleRect) { _, newValue in
                updateNavigationTitleOpacity(safeAreaInsets: geo.safeAreaInsets, titleRect: newValue)
            }
        }
    }

    private var titleAndDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(recipe.title)
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(.leading)
                .accessibilityIdentifier(AccessibilityIdentifiers.Recipe.title)
                .readRect($titleRect)

            Text(recipe.description)
                .accessibilityIdentifier(AccessibilityIdentifiers.Recipe.description)
        }
        .fontDesign(.serif)
    }

    private var detailsView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 200))], alignment: .leading, spacing: 16) {
            DurationLabelView(time: recipe.prepTime)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            DurationLabelView(time: recipe.cookTime)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            AmountLabelView(amount: recipe.amount, scale: .l)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .contentTransition(.identity)
        .compositingGroup()
    }

    private var ingredientsView: some View {
        VStack(spacing: 12) {
            Text("Ingredients")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
                .accessibilityIdentifier(AccessibilityIdentifiers.Recipe.ingredients)

            VStack(alignment: .leading, spacing: 16) {
                ForEach(recipe.ingredients, id: \.self, content: IngredientView.init)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func updateNavigationTitleOpacity(safeAreaInsets: EdgeInsets, titleRect: CGRect) {
        let offset = 1 + ((safeAreaInsets.top - titleRect.height - titleRect.minY)/titleRect.height)
        withAnimation {
            navigationTitleOpacity = max(min(offset, 1), 0)
        }
    }
}

extension Recipe.Amount.AmountType {
    var title: String {
        switch self {
        case .serves: "Serves"
        }
    }
}

#Preview {
    NavigationStack {
        RecipeView(recipe: .mock)
    }
    .environment(InspirationStore(client: MockInspirationClient()))
}
