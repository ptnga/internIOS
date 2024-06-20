import Foundation
import UIKit
class CustomLabel {
    func customLabel(label: UILabel, cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil, borderColor: CGColor? = nil, borderBackgroundColor: UIColor? = nil){
        if (cornerRadius != nil) {
            label.layer.cornerRadius = cornerRadius!
            label.layer.masksToBounds = true
            label.layer.borderWidth = borderWidth!
        }
        label.layer.borderColor = borderColor
        label.backgroundColor = borderBackgroundColor
    }
}
