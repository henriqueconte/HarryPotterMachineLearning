//
//  ViewControllerScreen.swift
//  HarryPotterMachineLearning
//
//  Created by Maria Eduarda Casanova Nascimento on 30/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import UIKit

protocol CodeView {
    func builViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView{
    func setupView(){
        builViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}

final class ViewControllerScreen: UIView {
      
    lazy var button: UIButton = {
        let view = UIButton(frame: .zero)
        view.backgroundColor = .black
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewControllerScreen : CodeView{
    func builViewHierarchy() {
        addSubview(button)
    }
    
    func setupConstraints() {
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        button.centerXAnchor.constraint(equalToSystemSpacingAfter: self.centerXAnchor, multiplier: 1).isActive = true
         
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .darkGray
    }
}
