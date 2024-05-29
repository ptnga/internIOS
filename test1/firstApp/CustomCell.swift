import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet private weak var textViewName: UILabel!
    @IBOutlet private weak var textViewContent: UILabel!
    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var textViewHour: UILabel!
    @IBOutlet private weak var labelNotify: UILabel!
    public func set(user: ChatModel) {
        cellImage.image = UIImage(named: user.nameImage)
        textViewName.text = user.username
        textViewContent.text = user.title
        textViewHour.text = user.timestamp
        if( user.numberNotify>0 ) {
            textViewName.textColor = UIColor.white
            textViewContent.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            textViewContent.textColor = UIColor.white
            labelNotify.backgroundColor = .red
            labelNotify.text = "\(user.numberNotify)"
            labelNotify.layer.cornerRadius = labelNotify.frame.height/2
            labelNotify.layer.masksToBounds = true
            labelNotify.layer.borderWidth = 1
            labelNotify.layer.borderColor = UIColor.red.cgColor
        }

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
}
