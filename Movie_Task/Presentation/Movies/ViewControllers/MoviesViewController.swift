//
//  MoviesViewController.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 14/07/2025.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var favouriteButton: UIButton!
    private var viewModel: MoviesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
        viewModel = DIContainer.shared.makeMoviesViewModel()
        bindViewModel()
        viewModel.loadMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            moviesCollectionView.reloadData()
        }

    
    private func bindViewModel() {
          viewModel.didUpdate = { [weak self] in
              DispatchQueue.main.async {
                  self?.moviesCollectionView.reloadData()
              }
          }
      }
    
    @IBAction func favouriteButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Favorite", bundle: nil)
           let vc = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
           navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = viewModel.movies[indexPath.item]
        cell.configure(with: movie)
        
        let favoriteMovie = FavoriteMovie(title: movie.title ?? "", posterPath: movie.posterPath ?? "")
        cell.updateFavorite(isFavorite: FavoritesManager.shared.isFavorite(favoriteMovie))
        cell.didSelectFavourite = {
            let isFavorite = FavoritesManager.shared.isFavorite(favoriteMovie)
            if isFavorite {
                FavoritesManager.shared.removeFavorite(favoriteMovie)
            } else {
                FavoritesManager.shared.addFavorite(favoriteMovie)
            }
            collectionView.reloadItems(at: [indexPath])
        }
        
        if indexPath.item == viewModel.movies.count - 1 && !viewModel.isLastPage {
                viewModel.loadMovies()
            }
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.item]
            
            let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
            guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
                print("❌ Failed to load MovieDetailsViewController from storyboard.")
                return
            }

            
            let repository = MovieRepositoryImpl()
            let useCase = FetchMovieDetailsUseCase(repository: repository)
            let viewModel = MovieDetailsViewModel(fetchMovieDetailsUseCase: useCase)
            detailsVC.viewModel = viewModel

            navigationController?.pushViewController(detailsVC, animated: true)
            viewModel.fetchDetails(for: movie.id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let padding: CGFloat = 5
        let totalPadding = (padding * (itemsPerRow + 1))
        let availableWidth = collectionView.bounds.width - totalPadding
        let widthPerItem = floor(availableWidth / itemsPerRow)
        let heightPerItem: CGFloat = 250 // Or any fixed height you prefer
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}
