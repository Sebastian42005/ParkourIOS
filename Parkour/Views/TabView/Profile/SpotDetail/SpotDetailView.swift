import SwiftUI

struct SpotDetailView: View {
    
    @ObservedObject var viewModel: SpotDetailViewModel
    var body: some View {
        VStack {
            HStack {
                ProfilePictureImageView(url: Gateway().getProfilePic(username: viewModel.user.username), size: 50)
                .padding(.leading, 3)
                LeftTextView(text: viewModel.user.username)
                    .bold()
                    .font(.system(size: 23))
                Text(viewModel.spot.city)
                    .padding(.trailing, 10)
                    .font(.system(size: 20))
            }
            .padding(.bottom, -0.1)
            UrlImage(url: Gateway().getImage(id: viewModel.spot.id))
            SpotOptionsView()
            HStack {
                Text(viewModel.spot.description)
                    .padding(.leading, 8)
                Spacer()
            }
            Spacer()
        }
    }
}

struct SpotOptionsView: View {
    let iconSize: Double;
    
    init(iconSize: Double = 25) {
        self.iconSize = iconSize
    }
    var body: some View {
        HStack {
            RatingView(iconSize: iconSize)
            Spacer()
        }
        .padding(.leading, 10)
    }
}

struct RatingView: View {
    @State var showRatingAlert = false
    @State var ratingText = ""
    let iconSize: Double;
    @State var stars: Int = 0
    
    init(iconSize: Double = 30) {
        self.iconSize = iconSize
    
    }
    
    var body: some View {
        LazyHStack {
            ForEach(1..<6) { i in
                Image(systemName: i <= stars ? "star.fill" : "star")
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(.blue)
                .onTapGesture {
                    stars = i
                    showRatingAlert = true
                }
            }
        }
        .frame(height: iconSize)
        .alert("Rating", isPresented: $showRatingAlert, actions: {
            TextField("Comment (optional)", text: $ratingText)
            Button("Cancel") {}
            Button("Rate") {
                
            }
        })
    }
}

struct LeftTextView: View {
    let text: String;
    var body: some View {
        HStack {
            Text(text)
            Spacer()
        }
    }
}

struct SpotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpotDetailView(viewModel: SpotDetailViewModel(spot: Spot(id: 2, longitude: 2.2, latitude: 3.3, city: "Paris", description: "Hier ist die Beschreibung vom Bild bei dem der wunderschöne Baum drauf ist", spotType: "freerunning", user: nil)))
    }
}
