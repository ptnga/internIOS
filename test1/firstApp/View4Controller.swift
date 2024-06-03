import UIKit

public final class ChatModel {
    var nameImage: String
    var username: String
    var position: String
    var title: String
    var timestamp: Int
    var numberNotify: Int
    init(nameImage: String, username: String, position: String, title: String, timestamp: Int, numberNotify: Int) {
        self.nameImage = nameImage
        self.username = username
        self.position = position
        self.title = title
        self.timestamp = timestamp
        self.numberNotify = numberNotify
    }
    convenience init(json: [String: Any]) {
        let username = json["username"] as? String ?? ""
        let listNameFirst = username.split(separator: " ")
        var firstInitial = ""
        var secondInitial = ""

        if let firstChar = listNameFirst[0].first {
            firstInitial = String(firstChar)
        }
        if let secondChar = listNameFirst[1].first {
            secondInitial = String(secondChar)
        }
        let nameImage = firstInitial + secondInitial
        let position = json["position"] as? String ?? ""
        let message = json["message"] as? String ?? ""
        let timestamp = (json["time"] as? Int ?? 0)
        let numberNotify = (json["numer_unread"] as? Int ?? 0)
        
        self.init(nameImage: nameImage, username: username, position: position, title: message, timestamp: timestamp, numberNotify: numberNotify)
        }
}
class View4Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
     var users: [ChatModel] = []
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorView
        self.navigationItem.title = nil
        navigationController?.navigationBar.barTintColor = colorView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "menuIcon" ),
            style: .plain,
            target: self,
            action: nil
        )
        let menuButtonView = UIButton(type: .custom)
        menuButtonView.setImage(UIImage(named: "menuIcon" )?.withRenderingMode( .alwaysOriginal ), for: .normal)
        //        plusButtonView.imageView?.contentMode = .scaleAspectFill
        menuButtonView.clipsToBounds = true
        menuButtonView.contentVerticalAlignment = .fill
        menuButtonView.contentHorizontalAlignment = .fill
        menuButtonView.frame = CGRect( x: 0, y: 0, width: 34, height: 34 )
        let lefttButtonBar = UIBarButtonItem()
        lefttButtonBar.customView = menuButtonView
        self.navigationItem.leftBarButtonItem = lefttButtonBar
        let plusButtonView = UIButton( type: .custom)
        plusButtonView.setImage( UIImage( named: "plusIcon" )?.withRenderingMode( .alwaysOriginal ), for: .normal )
        //        plusButtonView.imageView?.contentMode = .scaleAspectFill
        plusButtonView.clipsToBounds = true
        plusButtonView.contentVerticalAlignment = .fill
        plusButtonView.contentHorizontalAlignment = .fill
        plusButtonView.frame = CGRect( x: 0, y: 0, width: 22, height: 18 )
        plusButtonView.addTarget(self, action: #selector( self.didTapButton), for: .touchUpInside )
        let rightButtonBar = UIBarButtonItem()
        rightButtonBar.customView = plusButtonView
        self.navigationItem.rightBarButtonItem = rightButtonBar
        tableView.backgroundColor = colorView
        view.applyKerning(1)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.reloadData()
        readJSONFile()
        
    }
    @objc private func didTapButton() {
        if let viewStartChat = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(
                withIdentifier: "startConversation"
            ) as? StartConversationController {
            navigationController?.pushViewController(viewStartChat, animated: true)
        }
    }
    func readJSONFile() {
            let fileName = "chat"
            let fileType = "json"
            if let path = Bundle.main.path( forResource: fileName, ofType: fileType ) {
                do {
                    let data = try Data(contentsOf: URL( fileURLWithPath: path ), options: .mappedIfSafe )
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any],
                       let jsonData = jsonObject["data"] as? [[String: Any]] {
                        users.removeAll()
                        for json in jsonData {
                            let chatModel = ChatModel(json: json)
                            users.append(chatModel)
                        }
                        tableView.reloadData()
                    }
                } catch {
                    print( "Error reading JSON file: \( error ) " )
                }
            }
        }
}
