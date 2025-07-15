//
//  MovieRepository.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 14/07/2025.
//

import Foundation

protocol MovieRepository {
    func fetchMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void)
//    func toggleFavorite(id: Int)
//    func isFavorite(id: Int) -> Bool
}
