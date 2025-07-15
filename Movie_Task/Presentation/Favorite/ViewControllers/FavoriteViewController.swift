//
//  FavoriteViewController.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 15/07/2025.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    private var favorites: [FavoriteMovie] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        favouriteCollectionView.delegate = self
        favouriteCollectionView.dataSource = self
        favouriteCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            favorites = FavoritesManager.shared.getFavorites()
            favouriteCollectionView.reloadData()
        }
    }

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = favorites[indexPath.item]
        cell.movieLabel.text = movie.title
        let urlString = "https://image.tmdb.org/t/p/w500/\(movie.posterPath)"
        cell.movieImageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholder.png"))
        cell.updateFavorite(isFavorite: FavoritesManager.shared.isFavorite(movie))
        cell.didSelectFavourite = {
            let isFavorite = FavoritesManager.shared.isFavorite(movie)
            if isFavorite {
                FavoritesManager.shared.removeFavorite(movie)
                self.favorites = FavoritesManager.shared.getFavorites()
                self.favouriteCollectionView.reloadData()
            }
            collectionView.reloadItems(at: [indexPath])
        }
        return cell
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
