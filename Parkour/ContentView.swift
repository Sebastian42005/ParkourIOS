//
//  ContentView.swift
//  Parkour
//
//  Created by Sebastian Ederer on 27.10.22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewHandler = ViewHandler()
    
    var body: some View {
        switch (viewHandler.page) {
        case .empty : EmptyView()
        case .login : RegisterView(viewModel: RegisterViewModel(isLogin: true, viewHandler: viewHandler))
        case .tabview : ParkourTabView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
