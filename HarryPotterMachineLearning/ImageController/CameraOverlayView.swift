//
//  CameraOverlayView.swift
//  HarryPotterMachineLearning
//
//  Created by Pedro Lopes on 30/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import UIKit

class CameraOverlayView: UIView {
    var imageController : ImageController?
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var changeCamerButton: UIButton!
    @IBOutlet weak var takePhotoArea: UIView!
    @IBOutlet var view: UIView!
    
    var imagePickerController: UIImagePickerController!
    
    init(frame: CGRect,imageController: ImageController) {
        super.init(frame: frame)
        self.imageController = imageController
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        UINib(nibName: "CameraOverlayView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
    
    func configure(imagePickerController: UIImagePickerController) {
        self.imagePickerController = imagePickerController
        self.imagePickerController.cameraDevice = .front
        self.imagePickerController.cameraFlashMode = .off
    }
    
    @IBAction func getImage(_ sender: Any) {
        guard let controller = imageController else { return }
        controller.pickerController.sourceType = .photoLibrary
        controller.presentationController?.show(controller.pickerController, sender:nil)
    }
    
    @IBAction func changeFlash(_ sender: UIButton) {
        if imagePickerController.cameraFlashMode == .off {
            flashButton.setBackgroundImage(UIImage(systemName: "bolt.fill"), for: .normal)
                
            imagePickerController.cameraFlashMode = .on
        } else {
            flashButton.setBackgroundImage(UIImage(systemName: "bolt.slash.fill"), for: .normal)
            imagePickerController.cameraFlashMode = .off
        }
    }
    
    @IBAction func takePicture(_ sender: UIButton) {

        self.imagePickerController.takePicture()
    }
    @IBAction func exit(_ sender: Any) {
        self.imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeCamera(_ sender: UIButton) {
        if imagePickerController.cameraDevice == .front {
            imagePickerController.cameraDevice = .rear
        } else {
            imagePickerController.cameraDevice = .front
        }
    }
}
