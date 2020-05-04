//
//  ViewController.swift
//  HarryPotterMachineLearning
//
//  Created by Henrique Figueiredo Conte on 29/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let shareWithFriends = ShareWithFriends()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //shareWithFriends.share(currentViewController: self, text: "I got 74% Hermione Granger! Check who you look like here!")
    }

}

