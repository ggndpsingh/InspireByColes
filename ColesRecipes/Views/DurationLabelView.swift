//
//  DurationLabelView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct DurationLabelView: View {

    let time: Recipe.Time
    var scale: DetailLabelView.Scale = .l

    var body: some View {
        DetailLabelView(
            icon: "timer",
            label: time.label,
            detail: time.duration.formatted(.units(width: .narrow, maximumUnitCount: 3)),
            note: time.note,
            scale: scale
        )
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 24) {
        DurationLabelView(time: .init(label: "Prep", durationAsMinutes: 15, note: "+ cooling time"), scale: .l)
        DurationLabelView(time: .init(label: "Prep", durationAsMinutes: 15, note: "+ cooling time"), scale: .s)
    }
    .padding()
}
