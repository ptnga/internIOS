//
//  ExtensionTextView.swift
//  firstApp
//
//  Created by Bunn on 17/6/24.
//

import Foundation
import UIKit
extension UITextView {
    func applyKerning(_ kernValue: CGFloat) {
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText)
        attributedString.addAttribute(
            .kern, value: kernValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        self.attributedText = attributedString
        
        for subview in self.subviews {
            if let textView = subview as? UITextView {
                textView.applyKerning(kernValue)
            }
        }
    }
}
