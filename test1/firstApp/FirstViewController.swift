import UIKit

class FirstViewController: UIViewController {
    let colorBT = UIColor(rgb: 0x536DFE, alpha: 1.0)
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var firstBT: UIButton!
    @IBAction func onPressedButton(_ sender: Any) {
            guard let viewC = storyboard?.instantiateViewController(identifier: "first") as? ViewController else {
                // identifier: định danh ViewController
                // hàm này cho phép xác định và khởi tạo config viewcontroller
                print("err")
                return
            }
            viewC.modalPresentationStyle = .fullScreen
            present(viewC, animated: true)
            // present(SecondViewController(),animated: true)
        }
    @IBAction func onPressedChatButton(_ sender: Any) {
            guard let vc4 = storyboard?.instantiateViewController(identifier: "chat") as? View4Controller else {
                // identifier: định danh ViewController
                // hàm này cho phép xác định và khởi tạo config viewcontroller
                print("err")
                return
            }
            vc4.modalPresentationStyle = .fullScreen
            present(vc4, animated: true)
            // present(SecondViewController(),animated: true)
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
