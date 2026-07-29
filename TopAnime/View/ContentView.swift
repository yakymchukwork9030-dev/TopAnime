//
//  ContentView.swift
//  TopAnime
//
//  Created by Maksym Yakymchuk on 29.05.2026.
//

import SwiftUI

struct ContentView: View {

    @Bindable var viewModel: AnimeViewModel

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Anime")
                .task {
                    await viewModel.load()
                }
        }
    }
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: 200)
        case .empty:
            EmptyStateView(title: "No anime", subtitle: "Try reloading or check the API")
        case .content:
            List(viewModel.animes) { anime in
                AnimeRow(anime: anime)
            }
        case .error(let message):
            ErrorView(message: message) {
                Task {
                    await viewModel.load()
                }
            }
        }
    }

}

#Preview {
    ContentView(viewModel: AnimeViewModel(service: AnimeService()))
}
