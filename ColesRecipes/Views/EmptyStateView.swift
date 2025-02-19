//
//  EmptyStateView.swift
//  ColesRecipes
//

import SwiftUI

struct EmptyStateView: View {

    var error: Error?
    var retryAction: (() -> Void)?

    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(.yellow.opacity(0.6))
                    .frame(width: 160, height: 160)

                Image(systemName: "cooktop")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)

                Image(systemName: "line.diagonal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                    .foregroundStyle(.red)
            }
            .fontWeight(.light)
            .padding(.bottom, 48)


            Text("Recipe Muse on a Coffee Break!")
                .font(.headline)

            Text("Our creative chef is off grabbing a coffee. Fresh ideas are brewing—check back soon!")
                .font(.callout)
                .foregroundStyle(.secondary)

            if let retryAction {
                Button("Retry", action: retryAction)
                    .buttonStyle(.borderedProminent)
                    .fontWeight(.bold)
            }

            Spacer()
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(24)
        .padding(.top, 48)
    }
}

#Preview {
    EmptyStateView(retryAction: {})
}
