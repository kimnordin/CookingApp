//
//  Coordinator.swift
//  CookApp
//
//  Created by Kim Nordin on 2021-08-13.
//

import UIKit


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: CameraPicker
    
    init(picker: CameraPicker) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.uiImage = selectedImage
//        self.picker.isPresented.wrappedValue.dismiss()
    }
}
