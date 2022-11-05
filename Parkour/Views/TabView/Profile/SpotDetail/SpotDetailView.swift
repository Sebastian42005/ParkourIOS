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
            SpotOptionsView(viewModel: viewModel)
            HStack {
                Text("Rating: \(viewModel.spot.getReadableRating())")
                    .bold()
                    .foregroundColor(.cyan)
                    .font(.system(size: 18))
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.bottom, 3)
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
    let viewModel: SpotDetailViewModel
    let iconSize: Double;
    
    init(iconSize: Double = 25, viewModel: SpotDetailViewModel) {
        self.iconSize = iconSize
        self.viewModel = viewModel
    }
    var body: some View {
        HStack {
            RatingView(iconSize: iconSize, viewModel: viewModel)
            Spacer()
        }
        .padding(.leading, 10)
    }
}

struct RatingView: View {
    let viewModel: SpotDetailViewModel
    @State var showRatingAlert = false
    @State var ratingText = ""
    let iconSize: Double;
    @State var stars: Int;
    
    init(iconSize: Double = 30, viewModel: SpotDetailViewModel) {
        self.iconSize = iconSize
        self.viewModel = viewModel
        self.stars = viewModel.spot.userRating
    }
    
    var body: some View {
        LazyHStack {
            ForEach(1..<6) { i in
                Image(systemName: i <= stars ? "star.fill" : "star")
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(.cyan)
                .onTapGesture {
                    stars = i
                    showRatingAlert = true
                }
            }
        }
        .frame(height: iconSize)
        .alert("Rating", isPresented: $showRatingAlert, actions: {
            TextField("Comment (optional)", text: $ratingText)
            Button("Cancel") {stars = viewModel.spot.userRating}
            Button("Rate") {
                viewModel.rateSpot(stars: stars, comment: ratingText)
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
        SpotDetailView(viewModel: SpotDetailViewModel(spot: Spot(id: 2, longitude: 2.2, latitude: 3.3, city: "Paris", description: "Hier ist die Beschreibung vom Bild bei dem der wunderschöne Baum drauf ist", spotType: "freerunning", user: nil, rating: 2.23, userRating: 1)))
    }
}
