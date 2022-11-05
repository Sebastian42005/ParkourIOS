//
//  User.swift
//  Parkour
//
//  Created by Sebastian Ederer on 03.11.22.
//

import Foundation

struct User: Codable, Hashable {
    let username: String
    let password: String
    let role: String
    let token: String?
    let spotList: [Spot]?
}
