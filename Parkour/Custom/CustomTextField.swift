//
//  CustomTextField.swift
//  Parkour
//
//  Created by Sebastian Ederer on 02.11.22.
//

import SwiftUI

struct CustomTextField: View {

    let lightGrey = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)
    var placeholder: String;
    @State var text: Binding<String>;
    var body: some View {
        TextField(placeholder, text: text)
            .accentColor(.black)
            .padding()
            .background(lightGrey)
            .foregroundColor(Color.black)
            .cornerRadius(20.0)
            .frame(height: 60)
            .padding(.trailing)
    }
}
