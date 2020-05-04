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
    var userImage: UIImage?
    var characterImage: UIImage?
    

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
        let tap = UITapGestureRecognizer(target: self, action: #selector(transformImage(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func transformImage(_ gesture: UIGestureRecognizer) {
        guard let userImage = userImage, let charImage = characterImage else {
            return
        }
        if imageView.image == userImage {
            imageView.transformImage(to: charImage, duration: 2.0)
        } else {
            imageView.transformImage(to: userImage, duration: 1.0)
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //shareWithFriends.share(currentViewController: self, text: "I got 74% Hermione Granger! Check who you look like here!")
    }
    @IBAction func getImage(_ sender: UIButton) {
        userImage = nil
        characterImage = nil
        imageController.present()
        class1Label.isHidden = true
        class2Label.isHidden = true
        class3Label.isHidden = true
        class1ValuePredict.isHidden = true
        class2ValuePredict.isHidden = true
        class3ValuePredict.isHidden = true
    }
    
    func magicUserToCharAnimation() {
        self.imageView.image = userImage
        var time = 0
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if time > 0 {
                self.imageView.transformImage(to: self.characterImage, duration: 4.0)
                timer.invalidate()

            } else {
                time += 1
            }
        }.fire()
    }
    
    func setCharImage(character: String) {
        self.characterImage = UIImage(named: character)
    }
    
    
}

extension ViewController: ImageControllerDelegate {
    func didSelect(image: UIImage?) {
        DispatchQueue.main.async {
            self.userImage = image
            let mlController = MLController()
            let predicts = mlController.predict(image: image).filter { $0.valuePredict >= 0.01
            }
            for i in 0 ..< (predicts.count < 3 ? predicts.count : 3) {
                switch i {
                case 0:
                    //set first predict as char image
                    self.setCharImage(character: predicts[i].name)
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
            // transform user image in char image animation
            self.magicUserToCharAnimation()
        }
    }
    
    
}

