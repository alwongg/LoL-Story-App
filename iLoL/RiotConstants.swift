//
//  RiotConstants.swift
//  iLoL
//
//  Created by Alex Wong on 8/2/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation

// MARK: - RiotClient (Constants)

extension RiotClient{
    
    // MARK: - Riot Error
    
    enum RiotError: Error {
        case NoDataRetrieved
    }
    
    // MARK: - Locale code for returned data
    
    enum Locale: String {
        case enUS = "en_US"
    }
    
    // MARK: - Constants
    
    struct Constants{
        
        // MARK: - API Key
        
        static let APIKey = "Enter Your API!"
        
        // MARK: - URLs
        
        static let championURL = "https://na1.api.riotgames.com/lol/static-data/v3/champions"
        static let imageURL = "https://ddragon.leagueoflegends.com/cdn/7.16.1/img/champion/"
    }
    
    
}
