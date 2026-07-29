//
//  EmptyStateView.swift
//  TopAnime
//
//  Created by Maksym Yakymchuk on 29.05.2026.
//

import SwiftUI

struct EmptyStateView: View {

    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "figure.roll.runningpace.circle.fill")
                .font(.system(size: 34))
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
