//
//  ProfileView.swift
//  Parkour
//
//  Created by Sebastian Ederer on 27.10.22.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage? = nil
    
    @ObservedObject var viewModel = ProfileViewModel()
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if image == nil {
                        ProfilePictureImageView(url: Gateway().getProfilePic(username: viewModel.user.username), size: 120)
                    }else {
                        Image(uiImage: image!)
                            .resizable()
                            .frame(width: 150, height: 150, alignment: .center)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.black, lineWidth: 3))
                    }
                }
                .onTapGesture {
                    showSheet = true
                }
                Text(viewModel.user.username)
                    .bold()
                    .font(.system(size: 28))
                Divider().background(.black)
                ProfileSpotListView(user: viewModel.user)
                    .padding(.top, -8)
                Spacer()
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
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                    }
            }
            .navigationBarTitle("Profile")
            .navigationBarItems(trailing: CreateNewSpotButton())
        }
    }
}

struct ProfileSpotListView: View {
    let user: User
    let columns = [
        GridItem(.fixed(UIScreen.main.bounds.size.width / 3)),
        GridItem(.fixed(UIScreen.main.bounds.size.width / 3)),
        GridItem(.fixed(UIScreen.main.bounds.size.width / 3))
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(user.spotList!, id:\.self) { spot in
                    AsyncImage(url: Gateway().getImage(id: spot.id)) { image in
                        NavigationLink(destination: SpotDetailView(viewModel: SpotDetailViewModel(spot: spot))) {
                            image.resizable()
                                .frame(width: UIScreen.main.bounds.size.width / 3, height: UIScreen.main.bounds.size.width / 3, alignment: .center)
                        }
                    } placeholder: {
                        ProgressView()
                            .frame(width: UIScreen.main.bounds.size.width / 3, height: UIScreen.main.bounds.size.width / 3, alignment: .center)
                    }
                }
            }
        }
    }
}

struct CreateNewSpotButton: View {
    var body: some View {
        NavigationLink {
            CreateSpotView()
        } label: {
            Image(systemName: "plus")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
