import UIKit

class ChatsTableViewCell: UITableViewCell {
    @IBOutlet private weak var textViewName: UILabel!
    @IBOutlet private weak var textViewContent: UILabel!
    @IBOutlet private weak var textViewHour: UILabel!
    @IBOutlet private weak var labelNotify: UILabel!
    @IBOutlet private weak var position: UILabel!
    @IBOutlet private weak var imageName: UILabel!
    @IBOutlet private weak var lbDot: UILabel!
    @IBOutlet private weak var lbBorder: UILabel!
    let colorBackgroundImage = UIColor(rgb: 0xFAD6DA, alpha: 1.0)
    let colorBorder =  UIColor(rgb: 0x5DE64E, alpha: 1.0)
    let colorFont = UIColor(rgb: 0xE65154, alpha: 1.0)
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    let colorNotify = UIColor(rgb: 0xED6348, alpha: 1.0)
    override func awakeFromNib() {
        super.awakeFromNib()
        textViewName.translatesAutoresizingMaskIntoConstraints = false
        textViewContent.translatesAutoresizingMaskIntoConstraints = false
        textViewHour.translatesAutoresizingMaskIntoConstraints = false
        // labelNotify.translatesAutoresizingMaskIntoConstraints = false
        position.translatesAutoresizingMaskIntoConstraints = false
        lbDot.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textViewName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 97),
            textViewName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            lbDot.leadingAnchor.constraint(equalTo: textViewName.trailingAnchor, constant: 10),
            lbDot.centerYAnchor.constraint(equalTo: textViewName.centerYAnchor),
            lbDot.widthAnchor.constraint(equalToConstant: 6),
            lbDot.heightAnchor.constraint(equalToConstant: 6),
            position.leadingAnchor.constraint(equalTo: lbDot.trailingAnchor, constant: 10),
            position.centerYAnchor.constraint(equalTo: textViewName.centerYAnchor),
            position.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            textViewContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 97),
            textViewContent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            textViewContent.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40),
            textViewContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -49),
            textViewHour.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 97),
             textViewHour.topAnchor.constraint(equalTo: textViewContent.bottomAnchor, constant: 4),
            textViewHour.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21)
        ])
    }
    public func set(user: ChatModel) {
        let customLB = CustomLabel()
        lbBorder.layer.backgroundColor = nil
        customLB.customLabel(
            label: lbBorder,
            cornerRadius: lbBorder.frame.height/2,
            borderWidth: 1)
        imageName.text = user.nameImage
        imageName.applyKerningLabel(1.3)
        customLB.customLabel(
            label: imageName,
            cornerRadius: imageName.frame.height/2,
            borderWidth: 1, 
            borderColor: colorView.cgColor,
            borderBackgroundColor: colorBackgroundImage
        )
        textViewName.text = user.username
        textViewName.applyKerningLabel(1.3)
        position.text = user.position
        position.applyKerningLabel(1.3)
        customLB.customLabel(
            label: lbDot,
            cornerRadius: lbDot.frame.height/2,
            borderWidth: 1
        )
        lbDot.sizeToFit()
        textViewContent.text = user.title
        textViewContent.applyKerningLabel(1.3)
        textViewHour.text = formatTimestamp(user.timestamp)
        textViewName.sizeToFit()
        position.sizeToFit()
        if( user.numberNotify>0 ) {
            textViewName.textColor = UIColor.white
            position.textColor = UIColor.white
            textViewContent.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            textViewContent.textColor = UIColor.white
            lbDot.backgroundColor = UIColor.white
            lbDot.layer.borderColor = UIColor.white.cgColor
            labelNotify.layer.isHidden = false
            labelNotify.text = "\(user.numberNotify)"
            customLB.customLabel(
                label: labelNotify,
                cornerRadius: labelNotify.frame.height/2,
                borderWidth: 1,
                borderColor: colorNotify.cgColor,
                borderBackgroundColor: colorNotify
            )
        } else {
            textViewName.textColor = UIColor.opaqueSeparator
            position.textColor = UIColor.opaqueSeparator
            textViewContent.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            textViewContent.textColor = UIColor.opaqueSeparator
            lbDot.backgroundColor = UIColor.opaqueSeparator
            lbDot.layer.borderColor = UIColor.opaqueSeparator.cgColor
            labelNotify.layer.isHidden = true
        }
        if(user.status == true) {
            lbBorder.layer.borderColor = colorBorder.cgColor
        } else {
            lbBorder.layer.borderColor = colorView.cgColor
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
