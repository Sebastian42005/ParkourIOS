//
//  ProfileViewModel.swift
//  Parkour
//
//  Created by Sebastian Ederer on 27.10.22.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    var cancel = Set<AnyCancellable>()
    @Published var user = User(username: "Sebastian", password: "", role: "", token: "", spotList: [Spot(id: 1, longitude: 2.2, latitude: 2.2, city: "Vienna", description: "", spotType: "freerunning", user: nil), Spot(id: 2, longitude: 2.2, latitude: 2.2, city: "Vienna", description: "", spotType: "freerunning", user: nil), Spot(id: 3, longitude: 2.2, latitude: 2.2, city: "Vienna", description: "", spotType: "freerunning", user: nil), Spot(id: 4, longitude: 2.2, latitude: 2.2, city: "Vienna", description: "", spotType: "freerunning", user: nil)])
    
    init() {
        getUser()
    }
    func getUser() {
        
        let publisher = Gateway().getUserByToken()
        
        publisher.sink { error in
            print(error)
        } receiveValue: { user in
            self.user = user
        }.store(in: &cancel)

    }
}
