//
//  ShareWithFriends.swift
//  HarryPotterMachineLearning
//
//  Created by Henrique Figueiredo Conte on 30/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import UIKit


class ShareWithFriends: UIViewController {
    
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func share(_ sender: Any) {
        let sharingText = "I got 71% Hermione Granger! Check who you look like here!"
        let sharingURL = URL(string: "https://apps.apple.com/br/app/spinning-shapes/id1475284364?l=en") ?? URL(fileURLWithPath: "")
        //let imageExample = Bundle.main.url(forResource: "image", withExtension: "jpg") //URL(fileURLWithPath: "Martinique")//UIImage(named: "Martinique")!
        
        let activityController = UIActivityViewController(activityItems: [sharingText, sharingURL], applicationActivities: nil)
        
        activityController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityController, animated: true, completion: nil)
    }

}
