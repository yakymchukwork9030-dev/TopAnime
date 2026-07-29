//
//  AnimeViewModel.swift
//  TopAnime
//
//  Created by Maksym Yakymchuk on 29.05.2026.
//
import Foundation
import Observation

@Observable
final class AnimeViewModel {

    enum State: Equatable {
        case loading
        case empty
        case content
        case error(String)
    }

    var animes: [Anime] = []
    var state = State.loading
    private let service: AnimeServiceProtocol

    init(animes: [Anime] = [], service: AnimeServiceProtocol) {
        self.animes = animes
        self.service = service
    }

    func load() async {
        do {
            animes = try await service.obtainAnime()
            state = animes.isEmpty ? .empty : .content
        } catch NetworkError.decodingFailed {
            animes = []
            state = .error("Failed to decode")
        } catch let NetworkError.badStatusCode(code) {
            animes = []
            state = .error("Server error with status: \(code)")
        } catch {
            animes = []
            state = .error("Unexpected error")
        }
    }
}
