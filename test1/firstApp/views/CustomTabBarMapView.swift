import Foundation
import UIKit
class CustomTabBarMapView: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                let mapViewController = MapViewController()
                var scaledImage: UIImage?
                if(index==0) {
                    scaledImage = mapViewController.resizeImage(image: item.image!, targetSize: CGSize(width: 32, height: 32))
                } else {
                    scaledImage = mapViewController.resizeImage(image: item.image!, targetSize: CGSize(width: 20.71, height: 22))
                }
                
                item.image = scaledImage
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
                item.imageInsets = UIEdgeInsets(top: 25, left: 0, bottom: -25, right: 83)
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "AvenirNext-DemiBold", size: 18) ?? UIFont.systemFont(ofSize: 18),
                    .foregroundColor: UIColor.white
                ]
                item.setTitleTextAttributes(attributes, for: .normal)
            }
        }
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .black
    }
}
