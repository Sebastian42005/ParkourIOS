//
//  SpotDetailViewModel.swift
//  Parkour
//
//  Created by Sebastian Ederer on 04.11.22.
//

import Foundation
import Combine

class SpotDetailViewModel: ObservableObject {
    var cancel = Set<AnyCancellable>()
    var cancel2 = Set<AnyCancellable>()
    var cancel3 = Set<AnyCancellable>()
    @Published var spot: Spot
    @Published var user: User = User(username: "", password: "", role: "", token: "", spotList: [])
    
    init(spot: Spot) {
        self.spot = spot
        setUser()
    }
    
    
    func setUser() {
        let publisher = Gateway().getSpotUser(id: spot.id)
        
        publisher.sink { error in
            print(error)
        } receiveValue: { user in
            self.user = user
        }.store(in: &cancel)
    }
    
    func getSpot() {
        let publisher = Gateway().getSpot(id: spot.id)
        
        publisher.sink { error in
            print(error)
        } receiveValue: { spot in
            self.spot = spot
        }.store(in: &cancel)
    }
    
    func rateSpot(stars: Int, comment: String) {
        let publisher = Gateway().rateSpot(spotId: spot.id, stars: stars, comment: comment)
        publisher.sink {error in
            print("SpotDetailView: \(error)")
        } receiveValue: { rating in
            self.getSpot()
        }.store(in: &cancel2)
    }
}
