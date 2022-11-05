import Foundation

struct Rating: Codable, Hashable {
    let id: Int
    let stars: Int
    let comment: String
}
