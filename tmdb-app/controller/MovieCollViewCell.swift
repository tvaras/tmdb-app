//
//  MovieCollectionViewCell.swift
//  tmdb-app
//
//  Created by training on 01-07-22.
//

import UIKit

class MovieCollViewCell: UICollectionViewCell {

    //@IBOutlet var movieImage: UIImageView!
   
    @IBOutlet weak var movieImage: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieToFavs: UIButton!
    var movieId: String!
    var delegate: MyCellDelegate?
    
    static let identifier = "MovieCollViewCell"

    @IBAction func movieImageTapped(_ sender: Any) {
        
        guard let movId = movieId else {
            return
        }
        
        print("movie_selected: \(movId)")
        
        self.delegate?.cellWasPressed(selectedMovieId: movId)
        
    }
    
    public func configure(with movie: PopularMovie) {
        
        if let urlImg : String = movie.backdropPath {
            self.movieImage.downloaded(from: Endpoints.imageBasePath + urlImg)
            self.movieImage.contentMode = .scaleAspectFill
            self.movieImage.adjustsImageSizeForAccessibilityContentSizeCategory = true
            self.movieImage.sizeThatFits(CGSize(width: 170, height: 130))
        }
    
        self.movieId = String(movie.id)
        self.movieName.text = movie.title
    }
}

extension UIButton {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.setImage(image, for: .normal)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


