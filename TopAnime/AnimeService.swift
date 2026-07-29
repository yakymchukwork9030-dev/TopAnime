//
//  AnimeService.swift
//  NetworkingLesson
//
//  Created by Maksym Yakymchuk on 21.05.2026.
//

import Foundation

protocol AnimeServiceProtocol {
    func obtainAnime() async throws -> [Anime]
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case badStatusCode(Int)
    case decodingFailed
}

class AnimeService: AnimeServiceProtocol {

    private let animeURL = "https://api.jikan.moe/v4/top/anime?type=tv"
    private let urlSession: URLSession
    private lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func obtainAnime() async throws -> [Anime] {
        guard let url = URL(string: animeURL) else {
            throw NetworkError.invalidResponse
        }

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await urlSession.data(for: urlRequest)

        guard let http = response as? HTTPURLResponse else {
           throw NetworkError.invalidResponse
        }

        guard (200...299).contains(http.statusCode) else {
            throw NetworkError.badStatusCode(http.statusCode)
        }

        do {
            let response = try decoder.decode(AnimeResponse.self, from: data)
            return response.data
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
