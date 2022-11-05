//
//  SpotListViewModel.swift
//  Parkour
//
//  Created by Sebastian Ederer on 27.10.22.
//

import Combine
import Foundation

class SpotListViewModel : ObservableObject {
    var cancel = Set<AnyCancellable>()
    @Published var spotList: [Spot] = []
    
    init() {
        getAllSpots()
    }
    
    func getAllSpots() {
        let publisher = Gateway().getSpots()
        
        publisher.sink { error in
            print(error)
        } receiveValue: { spots in
            print(spots.count)
            self.spotList = spots
        }.store(in: &cancel)

    }
}
