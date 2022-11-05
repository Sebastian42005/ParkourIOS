//
//  RegisterViewModel.swift
//  Parkour
//
//  Created by Sebastian Ederer on 02.11.22.
//

import Foundation
import Combine

class RegisterViewModel : ObservableObject{
    var cancel = Set<AnyCancellable>()
    @Published var username = ""
    @Published var password = ""
    @Published var isLogin: Bool
    @Published var isLoading = false
    @Published var viewHandler: ViewHandler
    
    init(isLogin: Bool, viewHandler: ViewHandler) {
        self.isLogin = isLogin
        self.viewHandler = viewHandler
    }
    
    func buttonClick(void: @escaping () -> Void) {
        self.isLoading.toggle()
        isLogin ? login() : register(void: void)
    }
    
    func login() {
        let publisher = Gateway().login(username: username, password: password)
        
        publisher.sink { error in
            print("RegisterView: \(error)")
        } receiveValue: { token in
            if (token.token != nil) {
                UserDefaults.standard.set(token.token, forKey: "token")
                self.viewHandler.page = .tabview
            }
            self.isLoading.toggle()
        }.store(in: &cancel)

    }
    
    func register(void: @escaping () -> Void) {
        let publisher = Gateway().register(username: username, password: password)
        
        publisher.sink { error in
            print("Register: \(error)")
        } receiveValue: { data in
            self.isLoading.toggle()
            void()
        }.store(in: &cancel)
    }
}
