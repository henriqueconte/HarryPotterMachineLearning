//
//  ResultViewController.swift
//  HarryPotterMachineLearning
//
//  Created by Pedro Lopes on 05/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var userImage: UIImage?
    private var characterImage: UIImage?
    private let shareWithFriends = ShareWithFriends()
    private let mlController = MLController()
    private var imageController: ImageController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterName.text = ""
        descriptionLabel.text = ""
        tryAgainButton.layer.cornerRadius = 13
        doneButton.layer.cornerRadius = 13
        imageController = ImageController(presentationController: self, delegate: self, useFaceOverlay: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(transformImage(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        addLoader()
        addBorder()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeLoader()
        guard let userImage = self.userImage else {
            return
        }
        
        if self.personFound(image: userImage) {
            self.detectHPCharacter(image: userImage)
        }
        else {
            self.displayAlert()
        }
    }
    
    func addBorder() {
        imageView.layer.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        imageView.layer.borderWidth = 6
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
    
    func displayAlert() {
        let alert = UIAlertController(title: "Are you a real wizard?", message: "It looks like no wizard face was found... Are you an infiltrated muggle?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    
    func addLoader() {
        let blackBlur: UIView = UIView()
        let loader: UIActivityIndicatorView = UIActivityIndicatorView()
        blackBlur.layer.name = "loaderSuperview"
        blackBlur.frame = view.bounds
        blackBlur.backgroundColor = .black
        blackBlur.alpha = 0.6
        loader.frame = blackBlur.bounds
        loader.style = .large
        loader.startAnimating()
        blackBlur.addSubview(loader)
        view.addSubview(blackBlur)
    }
    
    func removeLoader() {
        view.subviews.forEach{
            if $0.layer.name == "loaderSuperview" {
                $0.removeFromSuperview()
            }
        }
    }
    
    // MARK: Action functions
    
    @IBAction func share(_ sender: UIButton) {
        guard let char = characterName.text else {
            return
        }
        shareWithFriends.share(currentViewController: self, text: "I got \(char)! Check who you look like here!")
    }
    
    @IBAction func tryAgain(_ sender: UIButton) {
        imageController.showCamera()
        userImage = nil
        characterImage = nil
        imageView.image = #imageLiteral(resourceName: "selectorHat")
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


// MARK: Predict functions
extension ResultViewController {
    func personFound(image: UIImage) -> Bool {
        let predicts = self.mlController.predictPerson(image: image).filter { $0.valuePredict >= 0.01
        }
        
        if predicts.count > 0 {
            if predicts[0].name == "People" {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    func detectHPCharacter(image: UIImage) {
        let predicts = mlController.predictHPCharacter(image: image).filter { $0.valuePredict >= 0.01
        }
        guard let character = predicts.first else {
            return
        }
        setCharImage(character: character.name)
        characterName.text = character.name
        // MARK: Todo character description

        // transform user image in char image animation
        self.magicUserToCharAnimation()
    }
    
}

extension ResultViewController: ImageControllerDelegate {
    func didSelect(image: UIImage?) {
        DispatchQueue.main.async {
            //self.imageView.image = image
            self.userImage = image

        }
    }
    
    
}
