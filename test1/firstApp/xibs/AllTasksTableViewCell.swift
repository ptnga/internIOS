//
//  AllTasksTableViewCell.swift
//  firstApp
//
//  Created by Bunn on 24/6/24.
//

import UIKit

class AllTasksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var btStatus: UIButton!
    @IBOutlet weak var lbTaskName: UILabel!
    @IBOutlet weak var imageStore: UIImageView!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbCountry: UILabel!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var lbMin: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbDot: UILabel!
    @IBOutlet weak var lbReturn: UILabel!
    @IBOutlet weak var viewReturn: UIView!
    @IBOutlet weak var constraintBottom: NSLayoutConstraint!
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    let colorBt = UIColor(rgb: 0x536DFE, alpha: 1.0)
    override func awakeFromNib() {
        super.awakeFromNib()
        btStatus.translatesAutoresizingMaskIntoConstraints = false
    }
    public func set(task: TaskModel){
        let customLB = CustomLabel()
        viewName.backgroundColor = colorView
        viewTime.backgroundColor = colorView
        btStatus.backgroundColor = colorBt
        btStatus.tintColor = colorBt
        btStatus.layer.cornerRadius = btStatus.frame.height/2+2
        btStatus.layer.masksToBounds = true
        btStatus.layer.borderWidth = 1
        btStatus.layer.borderColor = colorBt.cgColor
        lbTaskName.text = task.taskname
        lbTaskName.applyKerningLabel(1)
        lbAddress.text = task.address
        lbAddress.applyKerningLabel(1)
        lbCountry.text = task.country
        lbCountry.applyKerningLabel(1)
        btStatus.setTitle("Accepted", for: .normal)
        btStatus.applyKerningToTitle(kernValue: 1)
        lbMin.text = ("\(task.min) min")
        lbMin.applyKerningLabel(1)
        constraintBottom.constant = 68
        customLB.customLabel(
            label: lbDot,
            cornerRadius: lbDot.frame.height/2,
            borderWidth: 1,
            borderBackgroundColor: .white
        )
        lbTime.text = formatTimestamp(task.timestamp)
        imageStore.isHidden = true
        viewReturn.isHidden = false
        lbReturn.applyKerningLabel(1)
        if(task.taskname == "Hub"){
            imageStore.isHidden = false
            viewReturn.isHidden = true
            constraintBottom.constant = 53
        }
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
