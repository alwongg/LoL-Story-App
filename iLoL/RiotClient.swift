//
//  RiotClient.swift
//  iLoL
//
//  Created by Alex Wong on 8/2/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation

// MARK: - RiotClient

class RiotClient: NSObject {
    
    // MARK: - Build the champion details

    private static func champion(fromJSON json: [String : Any]) -> ChampionDetails? {
        guard   let name = json["name"] as? String,
            let title = json["title"] as? String,
            let championID = json["id"] as? Int,
            let image = json["image"] as? [String: Any],
            let imageFull = image["full"] as? String,
            let photo = Constants.imageURL + imageFull as String?,
            let photoURL = URL(string: photo),
            let lore = json["lore"] as? String
            else    {return nil}
        
        return ChampionDetails(name: name, title: title, championID: championID, photoURL: photoURL, lore: lore)
    }
    
    // MARK: - Parse the JSON data
    
    static func champions(fromJSON data: Data) -> ChampionsResult {
        // Parse JSON with do catch block
        do {
            let parsedResult = try JSONSerialization.jsonObject(with: data, options: [])
            print(parsedResult)
            
            // if data exist, assign to dict
            guard   let dataDict = parsedResult as? [AnyHashable:Any],
                let champions = dataDict["data"] as? [String:[String:Any]]
                // if data does not exist, show fail msg
                else {return .failure(RiotError.noData)}
            
            var championsList = [ChampionDetails]()
            for (key, dict) in champions {
                if let champion = champion(fromJSON: dict) {
                    championsList.append(champion)
                }
            }
            
            // sort by name
            championsList.sort { $0.name < $1.name }
            
            return .success(championsList)
        } catch {
            return error as! ChampionsResult
        }
    }
    
    // Build URL from parameters with image and lore tags
    
    static var championsURL: URL {
        return riotURLFromParameters(locale: .enUS, tags: ["image", "lore"])
    }
    
    // MARK: - Helper for Creating a URL From Parameters
    
    private static func riotURLFromParameters(locale: Locale, tags: Set<String>?) -> URL {
        var components = URLComponents(string: Constants.championURL)!
        
        var queryItems = [URLQueryItem]()
        
        // Build with YOUR API -> Change API in RiotConstants file
        let API = ["api_key": Constants.APIKey]
        
        for (key, value) in API {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
    
        if let tags = tags {
            for tag in tags {
                let item = URLQueryItem(name: "tags", value: tag)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.url!
    }
}
