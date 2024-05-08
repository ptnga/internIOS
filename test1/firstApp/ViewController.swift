//
//  ViewController.swift
//  firstApp
//
//  Created by Bunn on 7/5/24.
//

import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
class ViewController: UIViewController {
    
   
   
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    let colorBT = UIColor(rgb: 0x536DFE)

    override func viewDidLoad() {
        super.viewDidLoad()
        button1.layer.cornerRadius = 25
        button1.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button1.layer.borderColor = colorBT.cgColor
        button1.backgroundColor = colorBT
        firstView.layer.cornerRadius = 15
        firstView.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }

//    @IBAction func onPressedButton(_ sender: Any) {
//        guard let vc = storyboard?.instantiateViewController(identifier: "second") as? SecondViewController else {
//            //identifier: định danh ViewController
//            //hàm này cho phép xác định và khởi tạo config viewcontroller
//            print("err")
//            return
//        }
//        present(vc, animated: true)
//        //present(SecondViewController(),animated: true)
//    }
    
}


