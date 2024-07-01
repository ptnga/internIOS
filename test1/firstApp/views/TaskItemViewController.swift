import UIKit

class TaskItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var task: [TaskModel] = []
    var detailItems: [ItemModel] = []
    @IBOutlet weak var tableViewDetailItem: UITableView!
    @IBOutlet weak var tableViewTaskName: UITableView!
    @IBOutlet weak var btCircle: UIButton!
    @IBOutlet weak var imgSlide1: UIImageView!
    @IBOutlet weak var imgSlide2: UIImageView!
    @IBOutlet weak var imgSlide3: UIImageView!
    @IBOutlet weak var lbSlidetoStart: UILabel!
    
    var imgs: [UIImageView] = []
    var initialPosition: CGFloat = 0.0 // Vị trí ban đầu của button trên trục X
    var minPosition: CGFloat = 30 // Vị trí tối thiểu của button trên trục X
    var maxPositions: [CGFloat] = [78, 97, 370] // Vị trí tối đa của từng label trên trục X
    var maxPosition: CGFloat = 380 // Vị trí tối đa của button trên trục X
    var labelAlphaMax: CGFloat = 1.0 // Độ mờ tối đa của label khi button đi đến vị trí tối đa
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorView
        setupTableView(tableView: tableViewTaskName, nibName: "TaskItemTableViewCell", rowHeigh: 234)
        setupTableView(tableView: tableViewDetailItem, nibName: "ItemTableViewCell", rowHeigh: 1880)
        readJSONFile(nameJosn: "tasks")
        readJSONFile(nameJosn: "items")
        tableViewTaskName.isScrollEnabled = false
        tableViewDetailItem.isScrollEnabled = false
        imgs = [imgSlide1,imgSlide2,imgSlide3]
        gestureButton(imgs: imgs, label: lbSlidetoStart)

        
    }
    func setupTableView(tableView: UITableView, nibName: String, rowHeigh: CGFloat) {
        tableView.backgroundColor = colorView
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        tableView.estimatedRowHeight = rowHeigh
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        
    }
    func readJSONFile(nameJosn: String) {
        if let jsonObject = ReadFileJson().readJsonFile(named: nameJosn, ofType: "json") {
            if(nameJosn == "tasks") {
                task.removeAll()
                if let jsonData = jsonObject["data"] as? [[String: Any]] {
                    task.removeAll()
                    for json in jsonData {
                        let taskModel = TaskModel(json: json)
                        task.append(taskModel)
                    }
                    tableViewTaskName.reloadData()
                }
            } else {
                detailItems.removeAll()
                if let jsonData = jsonObject["data"] as? [[String: Any]] {
                    detailItems.removeAll()
                    for json in jsonData {
                        let itemModel = ItemModel(json: json)
                        detailItems.append(itemModel)
                    }
                    tableViewDetailItem.reloadData()
                }
            }
            
        }
    }
    func gestureButton(imgs: [UIImageView], label: UILabel){
        // Thiết lập alpha ban đầu của label
        for img in imgs {
            img.alpha = 1.0
        }
        label.alpha = 1.0
        
//        // Thiết lập UILabel với giá trị ban đầu là 0
//        lbTest.text = "0"
        
        // Lưu vị trí ban đầu của button
        initialPosition = btCircle.center.x
        
        // Tạo UISwipeGestureRecognizer để nhận diện cử chỉ vuốt sang phải
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = .right
        
        // Thêm UISwipeGestureRecognizer vào UIButton
        btCircle.addGestureRecognizer(swipeRight)
        
        // Tạo UIPanGestureRecognizer để nhận diện cử chỉ vuốt
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        
        // Thêm UIPanGestureRecognizer vào UIButton
        btCircle.addGestureRecognizer(panGesture)
    }
    @objc func handleSwipeRight() {
        NotificationCenter.default.post(name: NSNotification.Name("SwipeRightNotification"), object: nil)
        tableViewTaskName.reloadData()
    }
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        // Di chuyển button theo cử chỉ vuốt
        if let buttonView = gesture.view {
            var newX = buttonView.center.x + translation.x
            for (index, maxPosition) in maxPositions.enumerated() {
                if newX <= maxPosition {
                    newX = max(minPosition, min(newX, maxPosition))
                    buttonView.center = CGPoint(x: newX, y: buttonView.center.y)
                    
                    // Tính toán alpha mới cho label tương ứng
                    let distance = abs(newX - initialPosition)
                    let newAlpha = 1.0 - min(distance / (maxPosition - initialPosition), 1.0) * labelAlphaMax
                    imgs[index].alpha = newAlpha
                    lbSlidetoStart.alpha = newAlpha
                    break
                }
            }
        }
        
        // Đặt lại translation về (0, 0) sau khi đã di chuyển
        gesture.setTranslation(CGPoint.zero, in: view)

        if gesture.state == .ended {
            let velocity = gesture.velocity(in: view)
            if velocity.x > 0 {
                NotificationCenter.default.post(name: NSNotification.Name("SwipeRightNotification"), object: nil)
                tableViewTaskName.reloadData()
            }
        }
    }
    

}
extension TaskItemViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewTaskName {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemTableViewCell", for: indexPath) as! TaskItemTableViewCell
            cell.backgroundColor = colorView
            let task = task[1]
            cell.set(task: task)
            return cell
        } else if tableView == tableViewDetailItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
            cell.backgroundColor = colorView
            let detailItem = detailItems[indexPath.row]
            cell.set(detailItem: detailItem)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
