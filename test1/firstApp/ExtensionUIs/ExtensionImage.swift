import UIKit

extension UIImage {
    func addText(_ text: String, fontSize: CGFloat) -> UIImage? {
        let font = UIFont.systemFont(ofSize: fontSize)
        let textColor = UIColor.white
        let textFontAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        let imageRect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: imageRect)
        
        let textRect = CGRect(x: 0, y: (size.height - fontSize) / 2, width: size.width, height: fontSize)
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
