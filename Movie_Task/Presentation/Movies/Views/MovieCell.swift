//
//  MovieCell.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 14/07/2025.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var didSelectFavourite: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with movie: Movie) {
        movieLabel.text = movie.title
        let urlString = "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"
        movieImageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholder.png"))
        }

    @IBAction func favouriteButtonSelect(_ sender: Any) {
        self.didSelectFavourite?()
    }
}
