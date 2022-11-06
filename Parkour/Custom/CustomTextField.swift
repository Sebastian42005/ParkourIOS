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
    var border: CGFloat
    @State var text: Binding<String>;
    
    init(placeholder: String, text: Binding<String>, border: CGFloat = 20) {
        self.placeholder = placeholder
        self.text = text
        self.border = border
    }
    var body: some View {
        TextField(placeholder, text: text)
            .accentColor(.black)
            .padding()
            .background(lightGrey)
            .foregroundColor(Color.black)
            .cornerRadius(border)
            .frame(height: 60)
    }
}
