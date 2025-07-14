//
//  MoviesViewModel.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 14/07/2025.
//

import Foundation

final class MoviesViewModel {
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private(set) var movies: [Movie] = []
    private(set) var currentPage = 1
    private(set) var isLastPage = false
    var didUpdate: (() -> Void)?

    init(fetchMoviesUseCase: FetchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }

    func loadMovies(reset: Bool = false) {
        if reset {
            currentPage = 1
            isLastPage = false
            movies = []
        }

        guard !isLastPage else { return }

        fetchMoviesUseCase.execute(page: currentPage) { [weak self] result in
            switch result {
            case .success(let newMovies):
                self?.movies.append(contentsOf: newMovies)
                self?.currentPage += 1
                self?.isLastPage = newMovies.isEmpty
                self?.didUpdate?()
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
}
