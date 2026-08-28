//
//  Anime.swift
//  TopAnime
//
//  Created by Maksym Yakymchuk on 29.05.2026.
//

import Foundation
struct AnimeResponse: Codable {
    let data: [Anime]
}

struct Anime: Codable, Identifiable {
    let id: Int
    let titleEnglish: String?
    let title: String
    let status: String
    let score: Double?
    let episodes: Int?
    let rank: Int?
    let images: AnimeImages
    let aired: AiredInfo

    var displayTitle: String {
        titleEnglish ?? title
    }

    var scoreFormatted: String {
        guard let score else { return "N/A" }
        return String(format: "%.2f", score)
    }

    enum CodingKeys: String, CodingKey {
        case id         = "mal_id"
        case titleEnglish = "title_english"
        case title
        case status
        case score
        case episodes
        case rank
        case images
        case aired
    }
}

struct AnimeImages: Codable {
    let jpg: ImageURLs

    struct ImageURLs: Codable {
        let imageUrl: String?
        let largeImageUrl: String?

        enum CodingKeys: String, CodingKey {
            case imageUrl      = "image_url"
            case largeImageUrl = "large_image_url"
        }
    }
}

struct AiredInfo: Codable {
    let from: String?
    var startDate: Date? {
        guard let from else { return nil }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: from)
    }

    var startDateFormatted: String {
        guard let date = startDate else { return "Невідомо" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}
