//
//  ErrorView.swift
//  TopAnime
//
//  Created by Maksym Yakymchuk on 29.05.2026.
//

import SwiftUI

struct ErrorView: View {

    let message: String
    var onRetry: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text(message)
                .font(.headline)
            Button("Retry", action: onRetry)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }
}
