//
//  Extension_UIImageView.swift
//  HarryPotterMachineLearning
//
//  Created by Pedro Lopes on 04/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func transformImage(to image: UIImage?, duration: CFTimeInterval) {
        self.image = image

        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade

        self.layer.add(transition, forKey: nil)
    }
}
