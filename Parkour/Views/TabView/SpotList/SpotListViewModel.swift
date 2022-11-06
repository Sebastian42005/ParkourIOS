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
    var cancel2 = Set<AnyCancellable>()
    @Published var showFilter = false;
    @Published var isFiltering = false;
    @Published var city = "";
    @Published var spotList: [Spot] = []
    
    init() {
        getAllSpots()
    }
    
    func getAllSpots() {
        let publisher = Gateway().getSpots()
        
        publisher.sink { error in
            print("ListView: \(error)")
        } receiveValue: { spots in
            self.spotList = spots
        }.store(in: &cancel)

    }
    
    func filterSpots(city: String, spotTypes: [SpotType]) {
        
        let publisher = Gateway().getSpots(city: city, spotTypes: spotTypes)
        
        publisher.sink { error in
            print("ListView: \(error)")
        } receiveValue: { spots in
            self.spotList = spots
            self.showFilter = false
            self.isFiltering = false
        }.store(in: &cancel2)
    }
}
