//
//  DurationLabelView.swift
//  ColesRecipes
//

import SwiftUI
import ColesInspire

struct DetailLabelView: View {

    let icon: String
    let label: String
    let detail: String
    var note: String?
    var scale: Scale = .l

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: scale == .l ? .top : .center, spacing: 4) {
                Image(systemName: icon)
                    .imageScale(scale == .l ? .large : .small)
                    .foregroundStyle(.accent)

                VStack(alignment: .leading, spacing: 0) {
                    if scale == .l {
                        Text(label)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .textCase(.uppercase)
                    }

                    Text(detail)
                        .font(scale == .l ? .body : .footnote)

                    if let note, scale == .l {
                        Text(note)
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .geometryGroup()
        .contentTransition(.identity)
        .font(.footnote)
        .fontWeight(.bold)
    }
}

extension DetailLabelView {
    enum Scale {
        case s, l
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 24) {
        DetailLabelView(icon: "person", label: "Serves", detail: "1")
        DetailLabelView(icon: "person", label: "Serves", detail: "1", scale: .s)
    }
    .padding()
}
