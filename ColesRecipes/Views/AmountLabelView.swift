//
//  DurationLabelView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct AmountLabelView: View {

    let amount: Recipe.Amount
    var scale: DetailLabelView.Scale = .l

    var body: some View {
        DetailLabelView(
            icon: "person.2",
            label: amount.amountType.title,
            detail: amount.value.formatted(),
            scale: scale
        )
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 24) {
        AmountLabelView(amount: .init(amountType: .serves, value: 3), scale: .l)
        AmountLabelView(amount: .init(amountType: .serves, value: 3), scale: .s)
    }
    .padding()
}
