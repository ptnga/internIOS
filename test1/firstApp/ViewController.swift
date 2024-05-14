//
//  ViewController.swift
//  firstApp
//
//  Created by Bunn on 7/5/24.
//

import UIKit

class ViewController: UIViewController {
    
   
   
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    let colorBT = UIColor(rgb: 0x536DFE, a: 1.0)
    let colorView = UIColor(rgb: 0x303034, a: 1.0)

    @IBAction func onPressedCall(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "two") as? View3Controller else {
            //identifier: định danh View3Controller
            //hàm này cho phép xác định và khởi tạo config viewcontroller
            print("err")
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.layer.cornerRadius = 25
        button1.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = nil
        button.layer.borderColor = UIColor.white.cgColor
        button1.layer.borderColor = colorBT.cgColor
        button1.backgroundColor = colorBT
        firstView.layer.cornerRadius = 15
        firstView.layer.borderWidth = 1
        firstView.layer.borderColor = colorView.cgColor
        firstView.backgroundColor = colorView
        // Do any additional setup after loading the view.
    }
    
}


