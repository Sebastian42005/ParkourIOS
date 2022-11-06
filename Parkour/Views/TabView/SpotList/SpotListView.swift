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
            .navigationBarItems(trailing: Button("Filter") {
                viewModel.showFilter.toggle()
            })
            .sheet(isPresented: $viewModel.showFilter) {
                FilterView(viewModel: viewModel)
            }
        }
    }}

struct FilterView: View {
    @ObservedObject var viewModel: SpotListViewModel
    let lightGrey = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)
    @State var spotTypeList: [SpotType] = SpotType.allCases
    var body: some View {
        NavigationView {
            VStack {
                CustomTextField(placeholder: "City", text: $viewModel.city, border: 15)
                    .padding()
                LeftTextView("Spot Types")
                    .bold()
                    .font(.system(size: 20))
                checkboxes
                CustomButton(isLoading: $viewModel.isFiltering, title: "Filter") {
                    viewModel.isFiltering = true
                    viewModel.filterSpots(city: viewModel.city, spotTypes: spotTypeList)
                }
                Spacer()
            }
            .navigationBarTitle("Filter")
        }
    }
    
    var checkboxes: some View {
        LazyVStack {
            ForEach(SpotType.allCases, id:\.self) {spotType in
                HStack {
                    HStack {
                        Image(systemName: spotTypeList.contains(spotType) ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text(spotType.getReadable())
                            .font(.system(size: 17))
                    }.onTapGesture {
                        if spotTypeList.contains(spotType) {
                            spotTypeList.removeAll {$0.rawValue == spotType.rawValue}
                        }else {
                            spotTypeList.append(spotType)
                        }
                    }
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 1)
            }
        }
        .padding(.top, -8)
    }
}

struct SpotListView_Previews: PreviewProvider {
    static var previews: some View {
        SpotListView()
    }
}
