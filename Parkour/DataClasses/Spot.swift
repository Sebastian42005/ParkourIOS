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
    let rating: Double
    let userRating: Int
    
    func getReadableRating() -> String {
        var readableRating = String(format: "%g", rating)
        return readableRating
    }
}

enum SpotType: String, Hashable, CaseIterable{
    case parkour = "parkour"
    case freerunning = "freerunning"
    case calisthenics = "calisthenics"
    
    func getReadable() -> String {
        return self.rawValue.capitalizedString
    }
}
