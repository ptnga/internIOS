import UIKit

class TaskItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbCountry: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var btStatus: UIButton!
    @IBOutlet weak var lbTaskName: UILabel!
    
    let colorBt = UIColor(rgb: 0x536DFE, alpha: 1.0)
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSwipeRightNotification),
            name: NSNotification.Name("SwipeRightNotification"),
            object: nil
        )
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SwipeRightNotification"), object: nil)
    
    }
    public func set(task: TaskModel){
        btStatus.backgroundColor = colorBt
        btStatus.tintColor = colorBt
        btStatus.layer.cornerRadius = 20
        btStatus.layer.masksToBounds = true
        btStatus.layer.borderWidth = 1
        btStatus.layer.borderColor = colorBt.cgColor
        lbTaskName.text = task.taskname
        lbTaskName.applyKerningLabel(1)
        lbAddress.text = task.address
        lbAddress.applyKerningLabel(1)
        lbCountry.text = task.country
        lbCountry.applyKerningLabel(1)
        btStatus.applyKerningToTitle(kernValue: 1)
        lbTime.text = formatTimestamp(task.timestamp)
    }
    @objc func handleSwipeRightNotification() {
        btStatus.setTitle("En Route", for: .normal)
    }
    private func formatTimestamp(_ timestamp: Int) -> String? {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: date)
    }
    
    
}
