//
//  MovieCollectionViewCell.swift
//  tmdb-app
//
//  Created by training on 01-07-22.
//

import UIKit

class MovieCollViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieToFavs: UIButton!
    var movieId: String!
    var delegate: MyCellDelegate?
    
    static let identifier = "MovieCollViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        guard let movId = movieId else {
            return
        }

        print("movie_selected: \(movId)")

        self.delegate?.cellWasPressed(selectedMovieId: movId)
    }
    
    public func configure(with movie: PopularMovie) {
        
        if let urlImg : String = movie.backdropPath {
            print("movie_image_endpoint: \(Endpoints.imageBasePath + urlImg)")
            self.movieImage.downloaded(from: Endpoints.imageBasePath + urlImg)
            self.movieImage.contentMode = .scaleAspectFill
        }
    
        self.movieId = String(movie.id)
        self.movieName.text = movie.title
    }
}


