//
//  ChampionDetailsEquatable.swift
//  iLoL
//
//  Created by Alex Wong on 8/11/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation

extension ChampionDetails: Equatable {
    static func == (lhs: ChampionDetails, rhs: ChampionDetails) -> Bool {
        return lhs.championID == rhs.championID
    }
}
