//
//  RiotError&Result.swift
//  iLoL
//
//  Created by Alex Wong on 8/2/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import Foundation

enum ChampionError: Error {
    case championImageCreationError
}

enum ChampionsResult {
    case success([ChampionDetails])
    case failure(Error)
}
