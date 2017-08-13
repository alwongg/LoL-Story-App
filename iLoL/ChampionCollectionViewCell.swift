//
//  ChampionCollectionViewCell.swift
//  iLoL
//
//  Created by Alex Wong on 8/2/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit
import Foundation

// MARK: - ChampionCollectionViewCell

class ChampionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityLoader: UIActivityIndicatorView!
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateUI(with: nil)
    }
    
    // MARK: - Update Method
    
    func updateUI(with image: UIImage?) {
        if let displayImage = image {
            activityLoader.stopAnimating()
            imageView.image = displayImage
        } else {
            activityLoader.startAnimating()
        }
    }
}
