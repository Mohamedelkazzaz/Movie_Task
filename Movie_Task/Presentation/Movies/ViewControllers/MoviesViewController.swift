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
    
    private func bindViewModel() {
          viewModel.didUpdate = { [weak self] in
              DispatchQueue.main.async {
                  self?.moviesCollectionView.reloadData()
              }
          }
      }
    
    @IBAction func favouriteButtonPressed(_ sender: Any) {
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
        
        if indexPath.item == viewModel.movies.count - 1 && !viewModel.isLastPage {
                viewModel.loadMovies()
            }
        
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
        let padding: CGFloat = 10
        let totalSpacing = (itemsPerRow + 1) * padding

        let availableWidth = collectionView.bounds.width - totalSpacing
        let widthPerItem = floor(availableWidth / itemsPerRow)
        let heightPerItem: CGFloat = 250

        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
