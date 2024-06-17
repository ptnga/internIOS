//
//  uiView.swift
//  firstApp
//
//  Created by Bunn on 14/5/24.
//

import Foundation
import UIKit
extension UIView {
    func applyKerning(_ kernValue: CGFloat) {
        if let textView = self as? UITextView {
            let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
            attributedString.addAttribute(
                .kern, value: kernValue,
                range: NSRange(
                    location: 0,
                    length: attributedString.length)
            )
            textView.attributedText = attributedString
        }
        for subview in subviews {
            subview.applyKerning(kernValue)
        }
    }
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}
