//
//  ProfilePictureImageView.swift
//  Parkour
//
//  Created by Sebastian Ederer on 04.11.22.
//

import SwiftUI

struct ProfilePictureImageView: View {
    let url: URL
    let size: Double;
    let border: CGFloat;
    
    init(url: URL, size: Double = 150, border: CGFloat = 2) {
        self.url = url
        self.size = size
        self.border = border
    }
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
                .frame(width: size, height: size, alignment: .center)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.black, lineWidth: border))
        } placeholder: {
            ProgressView()
                .frame(width: size, height: size, alignment: .center)
        }
    }
}
