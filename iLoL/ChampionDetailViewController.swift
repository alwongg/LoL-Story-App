//
//  ViewController.swift
//  iLoL
//
//  Created by Alex Wong on 8/10/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

// MARK: - ChampionDetailViewController

class ChampionDetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    var champion: ChampionDetails! {
        didSet {
            navigationItem.title = champion.name
        }
    }
    var store: ChampionStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchChampionImage(for: champion) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }

        nameLabel.text = champion.name
        nameLabel.sizeToFit()
        titleLabel.text = champion.title
        titleLabel.sizeToFit()
    }
}


