import UIKit

class StartChatTableViewCell: UITableViewCell {
    @IBOutlet private weak var lbBorder: UILabel!
    @IBOutlet private weak var lbName: UILabel!
    @IBOutlet private weak var lbStatus: UILabel!
    @IBOutlet private weak var lbImage: UILabel!
    let colorBackgroundImage = UIColor(rgb: 0xFAD6DA, alpha: 1.0)
    let colorBorder =  UIColor(rgb: 0x5DE64E, alpha: 1.0)
    let colorFont = UIColor(rgb: 0xE65154, alpha: 1.0)
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    override func awakeFromNib() {
        super.awakeFromNib()
        lbName.translatesAutoresizingMaskIntoConstraints = false
        lbStatus.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraint for lbName
            lbName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 97),
            lbName.centerYAnchor.constraint(equalTo: lbImage.centerYAnchor),
            // Constraint for lbStatus
            lbStatus.leadingAnchor.constraint(equalTo: lbName.trailingAnchor, constant: 15),
            lbStatus.centerYAnchor.constraint(equalTo: lbName.centerYAnchor),
            lbStatus.widthAnchor.constraint(equalToConstant: 9),
            lbStatus.heightAnchor.constraint(equalToConstant: 9),
            lbStatus.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    public func set( user: UserModel ) {
        let customLB = CustomLabel()
        customLB.customLabel(
            label: lbBorder,
            cornerRadius: lbBorder.frame.height/2,
            borderWidth: 1,
            borderColor: colorView.cgColor
        )
        lbImage.text = user.nameImage
        lbImage.applyKerningLabel(1.3)
        customLB.customLabel(
            label: lbImage,
            cornerRadius: lbImage.frame.height/2,
            borderWidth: 1,
            borderColor: colorView.cgColor,
            borderBackgroundColor: colorBackgroundImage
        )
        customLB.customLabel(
            label: lbStatus,
            cornerRadius: lbStatus.frame.height/2,
            borderWidth: 1,
            borderColor: colorView.cgColor
        )
        
        lbName.text = user.username
        lbName.applyKerningLabel(1.3)
        lbName.textColor = UIColor.white
        lbName.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbName.sizeToFit()
        lbStatus.sizeToFit()
        if(user.status == true) {
            lbStatus.layer.isHidden = false
            lbBorder.layer.borderColor = colorBorder.cgColor
            lbStatus.layer.borderColor = UIColor.green.cgColor
            lbStatus.layer.backgroundColor = UIColor.green.cgColor
        } else {
            lbStatus.layer.isHidden = true
        }
    }

}
