//
//  ImageControllerDelegate.swift
//  HarryPotterMachineLearning
//
//  Created by Pedro Lopes on 30/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageControllerDelegate: class {
    func didSelect(image: UIImage?)
}
