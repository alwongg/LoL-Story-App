//
//  ChampionDetailViewController.swift
//  iLoL
//
//  Created by Alex Wong on 8/2/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

// MARK: - ChampionDetailViewController

class ChampionDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var champion: ChampionDetails!
    var storage: ChampionStorage!
    
    // MARK: - IBOutlet
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var storyTextView: UITextView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = champion.name
        titleLabel.text = champion.title
        storyTextView.text = champion.lore.replacingOccurrences(of: "<br>", with: "\n")
        
        storage.getChampionImage(for: champion) { (result) -> Void in
            
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .fail(error):
                print(error)
                self.nameLabel.text = "Image not loaded"
                
                DispatchQueue.main.async(execute: {
                    let alertController = UIAlertController(title: "No Internet Connection!", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){(result:UIAlertAction) -> Void in
                        return
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                })

            }
        }
    }
}


