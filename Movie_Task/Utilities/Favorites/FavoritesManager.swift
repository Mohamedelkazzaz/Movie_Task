//
//  FavoritesManager.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 15/07/2025.
//

import Foundation

final class FavoritesManager {
    static let shared = FavoritesManager()
    private let key = "favoriteMovies"

    private init() {}

    func getFavorites() -> [FavoriteMovie] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let movies = try? JSONDecoder().decode([FavoriteMovie].self, from: data) else {
            return []
        }
        return movies
    }

    func addFavorite(_ movie: FavoriteMovie) {
        var favorites = getFavorites()
        if !favorites.contains(movie) {
            favorites.append(movie)
            save(favorites)
        }
    }

    func removeFavorite(_ movie: FavoriteMovie) {
        var favorites = getFavorites()
        favorites.removeAll { $0 == movie }
        save(favorites)
    }

    func isFavorite(_ movie: FavoriteMovie) -> Bool {
        return getFavorites().contains(movie)
    }

    private func save(_ movies: [FavoriteMovie]) {
        if let data = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
