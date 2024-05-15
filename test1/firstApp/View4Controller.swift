import UIKit

public final class ChatModel {
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
    
    var users: [ChatModel] = []
    let colorView = UIColor(rgb: 0x303034, a: 1.0)
    
    @IBOutlet weak var tableView : UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorView
        
        self.navigationItem.title = nil
        navigationController?.navigationBar.barTintColor = colorView
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menuIcon" ), style: .plain, target: self, action: nil)
        let menuButtonView:UIButton = UIButton(type: .custom)
        menuButtonView.setImage(UIImage(named: "menuIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        plusButtonView.imageView?.contentMode = .scaleAspectFill
        menuButtonView.clipsToBounds = true
        menuButtonView.contentVerticalAlignment = .fill
        menuButtonView.contentHorizontalAlignment = .fill
        menuButtonView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let lefttButtonBar:UIBarButtonItem = UIBarButtonItem()
        lefttButtonBar.customView = menuButtonView
        self.navigationItem.leftBarButtonItem = lefttButtonBar
        
        
        let plusButtonView:UIButton = UIButton(type: .custom)
        plusButtonView.setImage(UIImage(named: "plusIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        plusButtonView.imageView?.contentMode = .scaleAspectFill
        plusButtonView.clipsToBounds = true
        plusButtonView.contentVerticalAlignment = .fill
        plusButtonView.contentHorizontalAlignment = .fill

        plusButtonView.frame = CGRect(x: 0, y: 0, width: 22, height: 18)
        plusButtonView.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        
        let rightButtonBar:UIBarButtonItem = UIBarButtonItem()
        rightButtonBar.customView = plusButtonView
        self.navigationItem.rightBarButtonItem = rightButtonBar
        
        tableView.backgroundColor = colorView
        view.applyKerning(1)
        
        let user1 = ChatModel(nameImage: "user1", username: "Erica Sanchez • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 2)
        let user2 = ChatModel(nameImage: "user2",username: "Abraham Dawson • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user3 = ChatModel(nameImage: "user3",username: "Sky High - All Drivers", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user4 = ChatModel(nameImage: "user1", username: "Erica Sanchez • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 2)
        let user5 = ChatModel(nameImage: "user2",username: "Abraham Dawson • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user6 = ChatModel(nameImage: "user3",username: "Sky High - All Drivers", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user7 = ChatModel(nameImage: "user1", username: "Erica Sanchez • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 2)
        let user8 = ChatModel(nameImage: "user2",username: "Abraham Dawson • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user9 = ChatModel(nameImage: "user3",username: "Sky High - All Drivers", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user10 = ChatModel(nameImage: "user1", username: "Erica Sanchez • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 2)
        let user11 = ChatModel(nameImage: "user2",username: "Abraham Dawson • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user12 = ChatModel(nameImage: "user3",username: "Sky High - All Drivers", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user13 = ChatModel(nameImage: "user1", username: "Erica Sanchez • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 2)
        let user14 = ChatModel(nameImage: "user2",username: "Abraham Dawson • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user15 = ChatModel(nameImage: "user3",username: "Sky High - All Drivers", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user16 = ChatModel(nameImage: "user1", username: "Erica Sanchez • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 2)
        let user17 = ChatModel(nameImage: "user2",username: "Abraham Dawson • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user18 = ChatModel(nameImage: "user3",username: "Sky High - All Drivers", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user19 = ChatModel(nameImage: "user2",username: "Abraham Dawson • Disatcher", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        let user20 = ChatModel(nameImage: "user3",username: "Sky High - All Drivers", title: "I Called. Fell free to give m...", timestamp: "02:45 PM", numberNotify: 0)
        users = [user1,user2,user3,user4,user5,user6,user7,user8,user9,user10,user11,user12,user13,user14,user15,user16,user17,user18,user19,user20]
        tableView.reloadData()
    }
    
    @objc private func didTapButton(){
        let vc = startConversationController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
