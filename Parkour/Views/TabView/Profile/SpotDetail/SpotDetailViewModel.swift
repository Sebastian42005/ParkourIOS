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
}
