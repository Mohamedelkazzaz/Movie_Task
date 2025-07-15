//
//  UseCase.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 14/07/2025.
//

import Foundation

final class FetchMoviesUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.fetchMovies(page: page, completion: completion)
    }
}

final class FetchMovieDetailsUseCase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        repository.fetchMovieDetails(movieId: movieId, completion: completion)
    }
}



//struct ToggleFavoriteUseCase {
//    let repository: MovieRepository
//    func execute(id: Int) {
//        repository.toggleFavorite(id: id)
//    }
//}
