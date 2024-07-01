import Foundation
import UIKit
extension UIButton {
    func applyKerningToTitle(kernValue: CGFloat) {
            guard let currentTitle = self.currentTitle, !currentTitle.isEmpty else {
                return
            }
            
            let attributedString: NSMutableAttributedString
            if let currentAttributedTitle = self.attributedTitle(for: .normal) {
                attributedString = NSMutableAttributedString(attributedString: currentAttributedTitle)
            } else {
                attributedString = NSMutableAttributedString(string: currentTitle)
            }
            
            attributedString.addAttribute(
                .kern,
                value: kernValue,
                range: NSRange(location: 0, length: attributedString.length)
            )
            
            self.setAttributedTitle(attributedString, for: .normal)
        }
}

