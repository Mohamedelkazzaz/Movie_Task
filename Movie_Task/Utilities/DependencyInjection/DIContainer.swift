//
//  DIContainer.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 14/07/2025.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    private init() {}

    func makeMoviesViewModel() -> MoviesViewModel {
        let repo = MovieRepositoryImpl()
        let useCase = FetchMoviesUseCase(repository: repo)
        return MoviesViewModel(fetchMoviesUseCase: useCase)
    }
    
}
