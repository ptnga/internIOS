//
//  FirstViewController.swift
//  firstApp
//
//  Created by Bunn on 8/5/24.
//

import UIKit


class FirstViewController: UIViewController {
    
    let colorBT = UIColor(rgb: 0x536DFE, a: 1.0)
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var firstBT: UIButton!
    @IBAction func onPressedButton(_ sender: Any) {
            guard let vc = storyboard?.instantiateViewController(identifier: "first") as? ViewController else {
                //identifier: định danh ViewController
                //hàm này cho phép xác định và khởi tạo config viewcontroller
                print("err")
                return
            }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            //present(SecondViewController(),animated: true)
        }
    @IBAction func onPressedChatButton(_ sender: Any) {
            guard let vc = storyboard?.instantiateViewController(identifier: "chat") as? View4Controller else {
                //identifier: định danh ViewController
                //hàm này cho phép xác định và khởi tạo config viewcontroller
                print("err")
                return
            }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            //present(SecondViewController(),animated: true)
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        firstBT.layer.cornerRadius = 25
        firstBT.layer.borderWidth = 1
        firstBT.backgroundColor = colorBT
        firstBT.layer.borderColor = colorBT.cgColor
        
        chatButton.layer.cornerRadius = 25
        chatButton.layer.borderWidth = 1
        chatButton.backgroundColor = colorBT
        chatButton.layer.borderColor = colorBT.cgColor

        // Do any additional setup after loading the view.
    }

}
