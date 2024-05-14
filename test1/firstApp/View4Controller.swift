import UIKit
class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var textView1a: UILabel!
    @IBOutlet weak var textView1b: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var textView1c: UILabel!
    @IBOutlet weak var labelNotify: UILabel!
    
}
final class ChatModel {
    var nameImage: String
    var username: String
    var title: String
    var timestamp: String
    var numberNotify: Int
    
    init(nameImage: String,username: String, title: String, timestamp: String, numberNotify: Int ){
        self.nameImage = nameImage
        self.username = username
        self.title = title
        self.timestamp = timestamp
        self.numberNotify = numberNotify
    }
}
class View4Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array: [(String, String, String)] = []
    var users: [ChatModel] = []
    let colorView = UIColor(rgb: 0x303034, a: 1.0)
    
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorView
        tableView.backgroundColor = colorView
        view.applyKerning(1)
        
        let user1 = ChatModel(nameImage: "user1", username: "Erica Sanchez • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 2)
        let user2 = ChatModel(nameImage: "user2",username: "Abraham Dawson • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user3 = ChatModel(nameImage: "user3",username: "Sky High - All Drivers", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        users = [user1,user2,user3]
        tableView.reloadData()
    }
   

}
