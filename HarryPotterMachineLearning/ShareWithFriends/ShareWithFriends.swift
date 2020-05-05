//
//  ShareWithFriends.swift
//  HarryPotterMachineLearning
//
//  Created by Henrique Figueiredo Conte on 30/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import UIKit


class ShareWithFriends {
    
    func share(currentViewController: UIViewController, text: String) {
        let sharingText = text
        let sharingURL = URL(string: "https://apps.apple.com/br/app/spinning-shapes/id1475284364?l=en") ?? URL(fileURLWithPath: "")
        
        let activityController = UIActivityViewController(activityItems: [sharingText, sharingURL], applicationActivities: nil)
        
        activityController.popoverPresentationController?.sourceView = currentViewController.view
        
        currentViewController.present(activityController, animated: true, completion: nil)
    }

}
