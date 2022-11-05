//
//  CreateSpotView.swift
//  Parkour
//
//  Created by Sebastian Ederer on 27.10.22.
//

import SwiftUI

struct CreateSpotView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image = UIImage(named: "profile")
    
    @ObservedObject var viewModel = CreateSpotViewModel()
    var body: some View {
        let coordinate = self.viewModel.location?.coordinate
        return NavigationView {
            VStack {
                if coordinate != nil {
                    Text("City: \(self.viewModel.city)")
                    Text("Latitude: \(coordinate!.latitude)")
                    Text("Longitude: \(coordinate!.longitude)")
                }
                Image(uiImage: image!)
                    .resizable()
                    .frame(width: (UIScreen.main.bounds.size.width - 10), height: 250, alignment: .center)
                Button("Choose Picture") {
                    showSheet = true
                }.padding()
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select"),
                                    buttons: [
                                        .default(Text("Library")) {
                                            self.showImagePicker = true
                                            self.sourceType = .photoLibrary
                                        },
                                        .default(Text("Camera")) {
                                            self.showImagePicker = true
                                            self.sourceType = .camera
                                        },
                                    ])
                    }
                CustomButton(isLoading: $viewModel.loading, title: "Upload", action: {
                    viewModel.loading = true
                    viewModel.createSpot(image: image!, void: {presentationMode.wrappedValue.dismiss()})
                })
            }
            .navigationBarTitle("Create Spot")
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

struct CreateSpotView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSpotView()
    }
}
