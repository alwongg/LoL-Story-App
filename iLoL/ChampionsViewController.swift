//
//  ChampionsViewController.swift
//  iLoL
//
//  Created by Alex Wong on 8/11/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

// MARK: - ChampionsViewController

class ChampionsViewController: UIViewController {

    // MARK: - Properties
    
    var champions = [ChampionDetails]()
    var store: ChampionStore!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
   
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        store.fetchChampions {
            (championsResult) -> Void in
            
            switch championsResult {
            case let .success(champions):
                print("Successfully found \(champions.count) champions.")
                self.champions = champions
            case let .failure(error):
                print("Error fetching champions: \(error)")
                self.champions.removeAll()
            }
            self.tableView.reloadSections(IndexSet(integer: 0)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath = tableView.indexPathsForSelectedItems?.first {
                
                let champion = self.champions[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! ChampionDetailViewController
                destinationVC.champion = champion
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}

// MARK: - UICollectionView

extension ChampionsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return champions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withReuseIdentifier: "TableViewCell", for: indexPath) as! ChampionTableViewCell
        
        return cell

    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let champion = self.champions[indexPath.row]
        
        // Download the image data
        store.fetchChampionImage(for: champion) { (result) -> Void in
            
            guard let championIndex = self.champions.index(of: champion),
                case let .success(image) = result else {
                    return
            }
            let championIndexPath = IndexPath(item: championIndex, section: 0)
            
            if let cell = self.tableView.cellForRow(at: championIndexPath) as?ChampionTableViewCell {
                cell.update(with: image)
            }
            
    
        }

    }
    

    
}
