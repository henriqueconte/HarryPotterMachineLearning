//
//  Extension_UILabel.swift
//  HarryPotterMachineLearning
//
//  Created by Pedro Lopes on 05/05/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func configDynamicFont(fontName: String, textStyle: UIFont.TextStyle) {
        guard let customFont = UIFont(name: fontName, size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the \(fontName) font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
        self.adjustsFontForContentSizeCategory = true
    }
}
