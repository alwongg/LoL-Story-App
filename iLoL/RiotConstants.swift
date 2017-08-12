//
//  RiotConstants.swift
//  iLoL
//
//  Created by Alex Wong on 8/11/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation

// MARK: - RiotClient (Constants)

extension RiotClient{
    
    // MARK: - Riot Error
    
    enum RiotError: Error {
        case noData
    }
    
    // MARK: - Locale code for returned data
    
    enum Locale: String {
        case enUS = "en_US"
    }
    
    // MARK: - Constants
    
    struct Constants{
        
        // MARK: - API Key
        
        static let APIKey = "RGAPI-ff5ba6e5-442a-41a3-9ae8-0e0500d18fe4"
        
        // MARK: - URLs
        
        static let championURL = "https://na1.api.riotgames.com/lol/static-data/v3/champions"
        static let imageURL = "https://ddragon.leagueoflegends.com/cdn/7.16.1/img/champion/"
    }
    
    
}
