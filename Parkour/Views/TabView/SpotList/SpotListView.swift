//
//  SpotListView.swift
//  Parkour
//
//  Created by Sebastian Ederer on 27.10.22.
//

import SwiftUI

struct SpotListView: View {
    @ObservedObject var viewModel = SpotListViewModel()
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.spotList, id:\.self) { spot in
                            SpotDetailView(viewModel: SpotDetailViewModel(spot: spot))
                        }
                    }
                }
            }
            .navigationBarTitle("Spot List")
            .navigationBarItems(trailing: CreateNewSpotButton())
        }
    }}

struct CreateNewSpotButton: View {
    var body: some View {
        NavigationLink {
            CreateSpotView()
        } label: {
            Image(systemName: "plus")
        }
    }
}

struct SpotListView_Previews: PreviewProvider {
    static var previews: some View {
        SpotListView()
    }
}
