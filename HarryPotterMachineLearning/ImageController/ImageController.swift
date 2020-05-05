//
//  ImageController.swift
//  HarryPotterMachineLearning
//
//  Created by Pedro Lopes on 30/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import UIKit

class ImageController: NSObject {
    let pickerController: UIImagePickerController
    weak var presentationController: UIViewController?
    private weak var delegate: ImageControllerDelegate?
    
    var useOverlay = false

    public init(presentationController: UIViewController, delegate: ImageControllerDelegate, useFaceOverlay: Bool) {
        self.pickerController = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
        self.useOverlay = useFaceOverlay
    }
   
    public func showGalery(){
        self.pickerController.sourceType = .savedPhotosAlbum
        self.presentationController?.present(self.pickerController, animated: true)
    }
    
    public func showCamera(){
        self.pickerController.sourceType = .camera
        self.presentationController?.present(self.pickerController, animated: true)
        if self.pickerController.sourceType == .camera {
            if self.useOverlay {
                guard let controller = presentationController else { return }
                let overlayView = CameraOverlayView(frame: controller.view.frame , imageController: self)
                overlayView.configure(imagePickerController: self.pickerController)
                self.pickerController.showsCameraControls = false
                overlayView.frame = (self.pickerController.cameraOverlayView?.frame)!
                self.pickerController.cameraOverlayView = overlayView
            }
        }
    }
        
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(image: image)
    }
}

extension ImageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage  {
            self.pickerController(picker, didSelect: editedImage)
        } else if let image = info[.originalImage] as? UIImage {
            self.pickerController(picker, didSelect: image)
        } else {
            return self.pickerController(picker, didSelect: nil)
        }
    }
}
