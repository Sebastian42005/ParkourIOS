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
        }
    }}

struct SpotListView_Previews: PreviewProvider {
    static var previews: some View {
        SpotListView()
    }
}
