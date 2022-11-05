//
//  RegisterView.swift
//  Parkour
//
//  Created by Sebastian Ederer on 02.11.22.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RegisterViewModel
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    CustomTextField(placeholder: "Username*", text: $viewModel.username)
                    CustomTextField(placeholder: "Password*", text: $viewModel.password)
                    if (viewModel.isLogin) {
                        NavigationLink(destination: RegisterView(viewModel: RegisterViewModel(isLogin: false, viewHandler: viewModel.viewHandler))) {
                            Text("Register")
                        }
                    }
                    CustomButton(isLoading: $viewModel.isLoading, title: viewModel.isLogin ? "Login": "Register") {
                        viewModel.buttonClick(void: {presentationMode.wrappedValue.dismiss()})
                    }
                }
                .padding(.top, 10)
                Spacer()
            }
            .padding()
            .navigationBarTitle(viewModel.isLogin ? "Login" : "Register")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel(isLogin: true, viewHandler: ViewHandler()))
    }
}
