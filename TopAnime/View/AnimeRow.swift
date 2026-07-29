//
//  AnimeRow.swift
//  TopAnime
//
//  Created by Maksym Yakymchuk on 29.05.2026.
//

import SwiftUI

struct AnimeRow: View {
    let anime: Anime
    private var statusColor: Color {
        anime.status == "Finished Airing" ? .blue : .green
    }

    var body: some View {
        HStack(spacing: 12) {
            posterImage

            VStack(alignment: .leading, spacing: 5) {
                ZStack {
                        Text(anime.status)
                            .font(.subheadline)
                            .foregroundStyle(statusColor)
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(statusColor, lineWidth: 1)
                            .frame(width: 120, height: 30)
                }
                HStack {
                    Text(anime.aired.startDateFormatted)
                    Text("| • \(anime.episodes ?? 0) ep.")

                }

                Text(anime.displayTitle)
                    .font(.headline)

                HStack {
                    Image(systemName: "star")
                    Text(anime.scoreFormatted)
                    Spacer()
                    Text(" # \(anime.rank ?? 0) ranking")
                }

            }
        }
    }

    @ViewBuilder
    private var posterImage: some View {
        if let urlString = anime.images.jpg.imageUrl,
           let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Image(systemName: "photo")
                        .foregroundStyle(.secondary)
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 100, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
            Image(systemName: "photo")
                .frame(width: 60, height: 84)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
