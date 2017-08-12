//
//  ChampionCoreData.swift
//  iLoL
//
//  Created by Alex Wong on 8/10/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ChampionStorage

class ChampionStorage {
    
    // MARK: - Properties
    
    let imageStore = ImageStorage()
    
    enum ChampionImageResult {
        case success(UIImage)
        case fail(Error)
    }
    
    // MARK: - Champion Image Request
    
    private func prepareChampionImage(data: Data?, error: Error?) -> ChampionImageResult {
        guard let imageData = data,
            let image = UIImage(data: imageData) else {
                
                // Couldn't create an image
                if data == nil {
                    return .fail(error!)
                } else {
                    return .fail(ChampionError.championImageCreationError)
                }
        }
        
        return .success(image)
    }
    
    // MARK: - Get the request image
    
    func getChampionImage(for champion: ChampionDetails, completion: @escaping (ChampionImageResult) -> Void) {
        
        let championIDString = String(champion.championID)
        let photoKey = championIDString
        if let image = imageStore.image(forKey: photoKey) {
            DispatchQueue.main.async(execute: {
                completion(.success(image)
            )})
           return
        }
        
        let photoURL = champion.photoURL
        let request = URLRequest(url: photoURL)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
 
            let result = self.prepareChampionImage(data: data, error: error)
            
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            DispatchQueue.main.async(execute: {
                completion(result)
            })
        }
        task.resume()
    }
    
    // MARK: - Champion Request
    
    private func prepareChampionRequest(data: Data?, error: Error?) -> ChampionsResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return RiotClient.champions(fromJSON: jsonData)
    }
    
    // MARK: - Get the champion
    
    func getChampion(completion: @escaping (ChampionsResult) -> Void) {
        let url = RiotClient.championsURL
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
            let result = self.prepareChampionRequest(data: data, error: error)
            DispatchQueue.main.async(execute: {
                completion(result)
            })
        }
        task.resume()
    }
    
    
}
