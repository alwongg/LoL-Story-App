//
//  Champion.swift
//  iLoL
//
//  Created by Alex Wong on 8/11/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation

// MARK: - ChampionStats

class ChampionDetails {
    let name: String
    let title: String
    let championID: Int
    let photoURL: URL
    let lore: String

    
    init(name: String, title: String, championID: Int, photoURL: URL, lore: String) {
        
        self.name = name
        self.title = title
        self.championID = championID
        self.photoURL = photoURL
        self.lore = lore

    }
}


