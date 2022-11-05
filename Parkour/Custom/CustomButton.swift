//
//  CustomButton.swift
//  Parkour
//
//  Created by Sebastian Ederer on 02.11.22.
//

import SwiftUI

struct CustomButton: View {
    
    
    @Binding var isLoading: Bool
    
    var title: String
    var textColor: Color?
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if isLoading {
                HStack(alignment: .center) {
                    ActivityIndicator(isAnimating: $isLoading, style: .medium)
                }
            } else {
                Text(title)
                    .font(.headline)
                    .foregroundColor(textColor ?? .white)
            }
        }
        .frame(width: 220, height: 60)
        .background(.cyan)
        .cornerRadius(35)
        .padding()
    }
}
