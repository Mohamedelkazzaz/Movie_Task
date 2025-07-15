//
//  MovieRepositoryImpl.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 14/07/2025.
//

import Foundation

final class MovieRepositoryImpl: MovieRepository {
 
    func fetchMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        APIClient.shared.request("/discover/movie", parameters: ["page": page]) { (result: Result<MovieResponseDTO, Error>) in
            switch result {
            case .success(let dto):
                let movies = dto.results?.compactMap { $0.toDomain() }
                completion(.success(movies ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        APIClient.shared.request("/movie/\(movieId)") { (result: Result<MovieDetailsDTO, Error>) in
            switch result {
            case .success(let dto):
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

