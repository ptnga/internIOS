import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var testBT: UIButton!
    @IBOutlet weak var lbTest: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    var imgs: [UIImageView] = []
    var initialPosition: CGFloat = 0.0 // Vị trí ban đầu của button trên trục X
    var minPosition: CGFloat = 50 // Vị trí tối thiểu của button trên trục X
    var maxPositions: [CGFloat] = [80, 95, 200] // Vị trí tối đa của từng label trên trục X
    var maxPosition: CGFloat = 240 // Vị trí tối đa của button trên trục X
    var labelAlphaMax: CGFloat = 1.0 // Độ mờ tối đa của label khi button đi đến vị trí tối đa
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgs = [img1,img2,img3]
        // Thiết lập alpha ban đầu của label
        for img in imgs {
                    img.alpha = 1.0
                }
        
        // Thiết lập UILabel với giá trị ban đầu là 0
        lbTest.text = "0"
        
        // Lưu vị trí ban đầu của button
        initialPosition = testBT.center.x
        
        // Tạo UISwipeGestureRecognizer để nhận diện cử chỉ vuốt sang phải
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = .right
        
        // Thêm UISwipeGestureRecognizer vào UIButton
        testBT.addGestureRecognizer(swipeRight)
        
        // Tạo UIPanGestureRecognizer để nhận diện cử chỉ vuốt
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        
        // Thêm UIPanGestureRecognizer vào UIButton
        testBT.addGestureRecognizer(panGesture)
    }
    
    @objc func handleSwipeRight() {
        // Khi vuốt sang phải, thay đổi giá trị của UILabel thành 1
        lbTest.text = "1"
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        // Di chuyển button theo cử chỉ vuốt
        if let buttonView = gesture.view {
            var newX = buttonView.center.x + translation.x
            
//            // Giới hạn di chuyển của button trong khoảng minPosition đến maxPosition
//            newX = max(minPosition, min(newX, maxPosition))
//            
//            buttonView.center = CGPoint(x: newX, y: buttonView.center.y)
//            
//            // Tính toán khoảng cách từ vị trí ban đầu của button đến vị trí hiện tại
//            let distance = abs(newX - initialPosition)
//            
//            // Tính toán alpha mới cho label dựa trên khoảng cách
//            let newAlpha = 1.0 - min(distance / (maxPosition - initialPosition), 1.0) * labelAlphaMax
//            lbAni.alpha = newAlpha
            // Giới hạn di chuyển của button trong khoảng minPosition đến maxPosition của từng label
                        for (index, maxPosition) in maxPositions.enumerated() {
                            if newX <= maxPosition {
                                newX = max(minPosition, min(newX, maxPosition))
                                buttonView.center = CGPoint(x: newX, y: buttonView.center.y)
                                
                                // Tính toán alpha mới cho label tương ứng
                                let distance = abs(newX - initialPosition)
                                let newAlpha = 1.0 - min(distance / (maxPosition - initialPosition), 1.0) * labelAlphaMax
                                imgs[index].alpha = newAlpha
                                break
                            }
                        }
        }
        
        // Đặt lại translation về (0, 0) sau khi đã di chuyển
        gesture.setTranslation(CGPoint.zero, in: view)
        
        // Kiểm tra nếu button đã di chuyển sang phải đủ khoảng cách
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: view)
            if velocity.x > 0 { // Vuốt sang phải
                lbTest.text = "1"
            }
        }
    }
}
