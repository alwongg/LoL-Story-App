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
    @IBOutlet weak var storyLabel: UILabel!
    
    var champion: ChampionDetails! {
        didSet {
            navigationItem.title = champion.name
        }
    }
    var storage: ChampionStorage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storage.getChampionImage(for: champion) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .fail(error):
                print("Error fetching image for photo: \(error)")
            }
        }

        nameLabel.text = champion.name
        titleLabel.text = champion.title
        storyLabel.text = champion.lore
        
    }
}


