//
//  uiLabel.swift
//  firstApp
//
//  Created by Bunn on 28/5/24.
//

import Foundation
import UIKit

extension UILabel {
    func applyKerningLabel(_ kernValue: CGFloat) {
        guard let currentText = self.text, !currentText.isEmpty else {
            return
        }
        
        let attributedString: NSMutableAttributedString
        if let currentAttributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: currentAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: currentText)
        }
        
        attributedString.addAttribute(.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
    
    func applyKerningToSubviews(_ kernValue: CGFloat) {
        applyKerningLabel(kernValue)
        for subview in subviews {
            if let label = subview as? UILabel {
                label.applyKerningLabel(kernValue)
            }
        }
    }
}
