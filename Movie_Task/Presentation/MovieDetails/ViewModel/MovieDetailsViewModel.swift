//
//  MovieDetailsViewModel.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 15/07/2025.
//

import Foundation

final class MovieDetailsViewModel {
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private(set) var movieDetails: MovieDetails?
    var onDetailsLoaded: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(fetchMovieDetailsUseCase: FetchMovieDetailsUseCase) {
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
    }

    func fetchDetails(for movieId: Int) {
        fetchMovieDetailsUseCase.execute(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let details):
                self?.movieDetails = details
                self?.onDetailsLoaded?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}
