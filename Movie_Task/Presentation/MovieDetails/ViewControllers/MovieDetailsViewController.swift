//
//  MovieDetailsViewController.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 15/07/2025.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieDetailsViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        bindViewModel()
    }
    
    private func bindViewModel() {
            viewModel.onDetailsLoaded = { [weak self] in
                guard let self = self, let details = self.viewModel.movieDetails else { return }
                self.titleLabel.text = details.title
                self.releaseDateLabel.text = details.releaseDate
                self.overviewLabel.text = details.overview
                self.navigationItem.title = details.title
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(details.posterPath)") {
                    URLSession.shared.dataTask(with: url) { data, _, _ in
                        if let data = data {
                            DispatchQueue.main.async {
                                self.movieImageView.image = UIImage(data: data)
                            }
                        }
                    }.resume()
                }
            }

            viewModel.onError = { error in
                print("Error loading details: \(error.localizedDescription)")
            }
        }


}
