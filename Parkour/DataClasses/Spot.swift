//
//  Spot.swift
//  Parkour
//
//  Created by Sebastian Ederer on 27.10.22.
//

import Foundation

// MARK: - SpotElement
struct Spot: Codable, Hashable {
    let id: Int
    let longitude, latitude: Double
    let city, description: String
    let spotType: String
    let user: User?
}
