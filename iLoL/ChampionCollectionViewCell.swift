//
//  ChampionCollectionViewCell.swift
//  iLoL
//
//  Created by Alex Wong on 8/11/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

// MARK: - ChampionCollectionViewCell

class ChampionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
    
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            activityLoader.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            activityLoader.startAnimating()
            imageView.image = nil
        }
    }
}
