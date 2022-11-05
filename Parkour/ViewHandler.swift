//
//  ContentViewModel.swift
//  Parkour
//
//  Created by Sebastian Ederer on 03.11.22.
//

import Foundation
import Combine

class ViewHandler: ObservableObject {
    @Published var page: CurrentPage = .empty
    var cancel = Set<AnyCancellable>()
    
    init() {
        let token = UserDefaults.standard.string(forKey: "token")
        print(token)
        guard let token = token else {return}
        let publisher = Gateway().verifyToken()
        
        publisher.sink { error in
            print(error)
        } receiveValue: { isVerifyed in
            self.page = isVerifyed.verified ? .tabview : .login
        }.store(in: &cancel)
    }
    
    
}

enum CurrentPage{
    case empty
    case login
    case tabview
}
