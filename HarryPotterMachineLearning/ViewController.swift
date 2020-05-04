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
    let mlController = MLController()

    @IBOutlet weak var class3ValuePredict: UILabel!
    @IBOutlet weak var class2ValuePredict: UILabel!
    @IBOutlet weak var class1ValuePredict: UILabel!
    @IBOutlet weak var class2Label: UILabel!
    @IBOutlet weak var class3Label: UILabel!
    @IBOutlet weak var class1Label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var imageController: ImageController!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageController = ImageController(presentationController: self, delegate: self, useFaceOverlay: true)
        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //shareWithFriends.share(currentViewController: self, text: "I got 74% Hermione Granger! Check who you look like here!")
    }
    @IBAction func getImage(_ sender: UIButton) {
        imageController.present()
        class1Label.isHidden = true
        class2Label.isHidden = true
        class3Label.isHidden = true
        class1ValuePredict.isHidden = true
        class2ValuePredict.isHidden = true
        class3ValuePredict.isHidden = true
    }
    
    func detectHPCharacter(image: UIImage) {
        let predicts = mlController.predictHPCharacter(image: image).filter { $0.valuePredict >= 0.01
        }
        for i in 0 ..< (predicts.count < 3 ? predicts.count : 3) {
            switch i {
            case 0:
                self.class1Label.text = predicts[i].name
                self.class1Label.isHidden = false
                self.class1ValuePredict.text = Int(predicts[i].valuePredict * 100).description
                self.class1ValuePredict.isHidden = false
            case 1:
                self.class2Label.text = predicts[i].name
                self.class2Label.isHidden = false
                self.class2ValuePredict.text = Int(predicts[i].valuePredict * 100).description
                self.class2ValuePredict.isHidden = false
            case 3:
                self.class3Label.text = predicts[i].name
                self.class3Label.isHidden = false
                self.class3ValuePredict.text = Int(predicts[i].valuePredict * 100).description
                self.class3ValuePredict.isHidden = false
            default:
                break
            }
        }
    }
    
}

extension ViewController: ImageControllerDelegate {
    func didSelect(image: UIImage?) {
        DispatchQueue.main.async {
            self.imageView.image = image
            
            let predicts = self.mlController.predictPerson(image: image).filter { $0.valuePredict >= 0.01
            }
            
            if predicts.count > 0 {
                if predicts[0].name == "People" {
                    self.detectHPCharacter(image: image ?? UIImage())
                }
                else if predicts[0].name == "Things" {
                    self.class1Label.text = "Not found"
                    self.class1Label.isHidden = false
                }
            }
        }
    }
    
    
}

