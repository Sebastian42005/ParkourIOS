//
//  ImagePicker.swift
//  Parkour
//
//  Created by Sebastian Ederer on 02.11.22.
//

import Foundation
import SwiftUI
import Combine

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var cancel = Set<AnyCancellable>()
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    init(image: Binding<UIImage?>, isShown: Binding<Bool>) {
        _image = image
        _isShown = isShown
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
    [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isShown = false
            
            let publisher = Gateway().setUserProfilePic(image: uiImage)
            publisher.sink { error in
                print(error)
            } receiveValue: { _ in
                print("Profile Pic Set")
            }.store(in: &cancel)
        }
    }
    func imagePickerControllerDidCancel(_picker: UIImagePickerController) {
        isShown = false
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType = .camera
    func updateUIViewController(_ uiViewController: UIImagePickerController, context:
                                 UIViewControllerRepresentableContext<ImagePicker>) {
    }
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isShown: $isShown)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) ->
    UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
}
