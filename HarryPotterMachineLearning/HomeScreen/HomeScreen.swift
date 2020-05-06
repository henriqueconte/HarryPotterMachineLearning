//
//  HomeScreen.swift
//  HarryPotterMachineLearning
//
//  Created by Henrique Figueiredo Conte on 05/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import UIKit


class HomeScreen: UIViewController {
    @IBOutlet weak var discoverImage: UIImageView!
    var imageController: ImageController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(discover(_:)))
        discoverImage.isUserInteractionEnabled = true
        discoverImage.addGestureRecognizer(tap)
        imageController = ImageController(presentationController: self, delegate: self, useFaceOverlay: true)
    }
    
    @objc func discover(_ tap: UITapGestureRecognizer) {
        imageController.showCamera()
    }
}

extension HomeScreen: ImageControllerDelegate {
    func didSelect(image: UIImage?) {
        DispatchQueue.main.async {
            guard let image = image else {
                return
            }
            let storyboard = UIStoryboard(name: "ResultScreenStoryboard", bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() as? ResultViewController else {
                return
            }
            vc.userImage = image
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
