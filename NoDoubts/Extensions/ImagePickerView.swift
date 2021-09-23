//
//  ImagePickerView.swift
//  WellyxStaff
//
//  Created by Qazi Mudasir on 23/07/2020.
//  Copyright © 2020 wellyx. All rights reserved.
//

import SwiftUI
//import CropViewController

 struct ImagePickerView: UIViewControllerRepresentable {

    //private var croppingStyle = CropViewCroppingStyle.default
    private let sourceType: UIImagePickerController.SourceType
    private let onCanceled: () -> Void
    private let onImagePicked: (UIImage?) -> Void
    
     init(sourceType: UIImagePickerController.SourceType, onCanceled: @escaping () -> Void, onImagePicked: @escaping (UIImage?) -> Void) {
       // self.croppingStyle = croppingStyle
        self.sourceType = sourceType
        self.onCanceled = onCanceled
        self.onImagePicked = onImagePicked
    }

     func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
//        if croppingStyle == .circular {
//            imagePicker.modalPresentationStyle = .popover
//            imagePicker.preferredContentSize = CGSize(width: 320, height: 568)
//        }
        imagePicker.sourceType = self.sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

     func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

     func makeCoordinator() -> Coordinator {
        Coordinator(
            onCanceled: self.onCanceled,
            onImagePicked: self.onImagePicked
        )
    }

    final  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        private let onCanceled: () -> Void
        private let onImagePicked: (UIImage?) -> Void

        init(onCanceled: @escaping () -> Void, onImagePicked: @escaping (UIImage?) -> Void) {
            self.onCanceled = onCanceled
            self.onImagePicked = onImagePicked
        }

         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
            guard let image = info[.originalImage] as? UIImage else {
                picker.dismiss(animated: true) {
                    self.onImagePicked(nil)
                }
                print("Image picker controller no working")
                return
            }
            
            picker.dismiss(animated: true) {
                self.onImagePicked(image)
            }
        }
        
         func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) {
                self.onCanceled()
            }
        }
    }
}
