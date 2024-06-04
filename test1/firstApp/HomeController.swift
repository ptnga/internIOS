import UIKit

class FirstViewController: UIViewController {
    let colorBT = UIColor(rgb: 0x536DFE, alpha: 1.0)
    @IBOutlet private weak var chatButton: UIButton!
    @IBOutlet private weak var firstBT: UIButton!
    @IBAction private func onPressedButton(_ sender: Any) {
            guard let viewC = storyboard?.instantiateViewController(identifier: "first") as? ViewController else {
                print("err")
                return
            }
            viewC.modalPresentationStyle = .fullScreen
            present(viewC, animated: true)
            // present(SecondViewController(),animated: true)
        }
    @IBAction func onPressedChatButton(_ sender: Any) {
        guard let chatView = storyboard?.instantiateViewController(identifier: "ChatsViewController") as? ChatsViewController else {
            print("err")
            return
        }
        chatView.modalPresentationStyle = .fullScreen
        present(chatView, animated: true)
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
