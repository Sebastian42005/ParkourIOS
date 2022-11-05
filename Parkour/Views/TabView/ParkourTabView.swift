//
//  ParkourTabView.swift
//  Parkour
//
//  Created by Sebastian Ederer on 03.11.22.
//

import SwiftUI

struct ParkourTabView: View {
    var body: some View {
        TabView {
            SpotListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Spot List")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct ParkourTabView_Previews: PreviewProvider {
    static var previews: some View {
        ParkourTabView()
    }
}
