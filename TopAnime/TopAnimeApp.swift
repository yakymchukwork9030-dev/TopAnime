//
//  TopAnimeApp.swift
//  TopAnime
//
//  Created by Maksym Yakymchuk on 29.05.2026.
//

import SwiftUI

@main
struct TopAnimeApp: App {

    @State private var viewModel = AnimeViewModel(service: AnimeService())
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
