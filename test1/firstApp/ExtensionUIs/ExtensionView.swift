//
//  uiView.swift
//  firstApp
//
//  Created by Bunn on 14/5/24.
//

import Foundation
import UIKit
extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}
