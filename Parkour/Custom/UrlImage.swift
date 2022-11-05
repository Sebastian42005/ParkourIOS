//
//  UrlImage.swift
//  Parkour
//
//  Created by Sebastian Ederer on 04.11.22.
//

import SwiftUI

struct UrlImage: View {
    let url: URL
    let width: Double;
    let height: Double;
    
    init(url: URL, width: Double = UIScreen.main.bounds.width, height: Double = UIScreen.main.bounds.width) {
        self.url = url
        self.width = width
        self.height = height
    }
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
                .frame(width: width, height: height, alignment: .center)
        } placeholder: {
            ProgressView()
                .frame(width: width, height: height, alignment: .center)
        }
    }
}
