//
//  CameraOverlayView.swift
//  HarryPotterMachineLearning
//
//  Created by Pedro Lopes on 30/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import UIKit

class CameraOverlayView: UIView {

    @IBOutlet weak var changeCamerButton: UIButton!
    @IBOutlet weak var takePhotoImage: UIImageView!
    @IBOutlet var view: UIView!
    
    var imagePickerController: UIImagePickerController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
    }
    
    
    @IBAction func takePicture(_ sender: UIButton) {
        self.imagePickerController.takePicture()
    }
    
    @IBAction func changeCamera(_ sender: UIButton) {
        if imagePickerController.cameraDevice == .front {
            imagePickerController.cameraDevice = .rear
        } else {
            imagePickerController.cameraDevice = .front
        }
    }
}
