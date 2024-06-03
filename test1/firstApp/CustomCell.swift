import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet private weak var textViewName: UILabel!
    @IBOutlet private weak var textViewContent: UILabel!
    @IBOutlet private weak var textViewHour: UILabel!
    @IBOutlet private weak var labelNotify: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var lbDot: UILabel!
    let colorBackgroundImage = UIColor(rgb: 0xFAD6DA, alpha: 1.0)
    let colorBorder =  UIColor(rgb: 0x5DE64E, alpha: 1.0)
    let colorFont = UIColor(rgb: 0xE65154, alpha: 1.0)
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    
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
            textViewContent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            textViewContent.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40),
            textViewContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
//            labelNotify.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 351),
//            labelNotify.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 42),
            textViewHour.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 97),
             textViewHour.topAnchor.constraint(equalTo: textViewContent.bottomAnchor, constant: 10),
            textViewHour.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    public func set(user: ChatModel) {
        imageName.text = user.nameImage
        imageName.applyKerningLabel(1.3)
        imageName.layer.cornerRadius = imageName.frame.height/2
        imageName.layer.masksToBounds = true
        imageName.layer.borderWidth = 1
        imageName.layer.backgroundColor = colorBackgroundImage.cgColor
        imageName.layer.borderColor = colorView.cgColor
        textViewName.text = user.username
        textViewName.applyKerningLabel(1.3)
        position.text = user.position
        position.applyKerningLabel(1.3)
        lbDot.layer.cornerRadius = lbDot.frame.height/2
        lbDot.layer.masksToBounds = true
        lbDot.layer.borderWidth = 1
        lbDot.backgroundColor = UIColor.opaqueSeparator
        lbDot.layer.borderColor = UIColor.opaqueSeparator.cgColor
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
            labelNotify.backgroundColor = .red
            labelNotify.text = "\(user.numberNotify)"
            labelNotify.layer.cornerRadius = labelNotify.frame.height/2
            labelNotify.layer.masksToBounds = true
            labelNotify.layer.borderWidth = 1
            labelNotify.layer.borderColor = UIColor.red.cgColor
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
extension View4Controller {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.backgroundColor = colorView
        let user = users[indexPath.row]
        cell.set(user: user)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 300
    }
}
