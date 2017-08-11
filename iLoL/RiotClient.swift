//
//  RiotAPI.swift
//  iLoL
//
//  Created by Alex Wong on 8/11/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation

// MARK: - RiotClient 

class RiotClient: NSObject {
    
    static var championsURL: URL {
        return riotURL(locale: .enUs, tags: ["image", "stats"])
    }
    
    private static func champion(fromJSON json: [String : Any]) -> ChampionDetails? {
        guard
            let name = json["name"] as? String,
            let title = json["title"] as? String,
            let championID = json["id"] as? Int,
            
            let image = json["image"] as? [String: Any],
            let imageFull = image["full"] as? String,
            let photo = Constants.baseImageURLString + imageFull as String?,
            let photoURL = URL(string: photo) else {
                
                // Don't have enough information to construct a champion
                return nil
        }
        
        return ChampionDetails(name: name, title: title, championID: championID, photoURL: photoURL)
    }
    
    static func champions(fromJSON data: Data) -> ChampionsResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            print(jsonObject)
            guard
                let jsonDictionary = jsonObject as? [AnyHashable:Any],
                let champions = jsonDictionary["data"] as? [String:[String:Any]] else {
                    
                    // JSON structure does not meet our expectations
                    return .failure(RiotError.invalidJSONData)
            }
            
            var championsList = [ChampionDetails]()
            for (_, championJSON) in champions {
                if let champion = champion(fromJSON: championJSON) {
                    championsList.append(champion)
                }
            }
            
            if championsList.isEmpty && !champions.isEmpty {
                // Was not able to parse any of the champions
                return .failure(RiotError.invalidJSONData)
            }
            
            championsList.sort { $0.name < $1.name }
            
            return .success(championsList)
        } catch let error {
            return .failure(error)
        }
    }
    
    enum RiotError: Error {
        case invalidJSONData
    }
    
    enum Locale: String {
        case enUs = "en_US"
    }

    
    private static func riotURL(locale: Locale, tags: Set<String>?) -> URL {
        var components = URLComponents(string: Constants.baseURLString)!
        
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "locale": locale.rawValue,
            "dataById": "false",
            "api_key": Constants.apiKey
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalTags = tags {
            for tag in additionalTags {
                let item = URLQueryItem(name: "tags", value: tag)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.url!
    }
}
