import UIKit

public final class UserModel {
    var nameImage: String
    var username: String
    var status: Bool
    var position: String
    // var numberStatus: Int
    init(nameImage: String, userName: String, status: Bool, position: String) {
        self.nameImage = nameImage
        self.username = userName
        self.status = status
        self.position = position
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
            let status = (json["status"] as? Int ?? 0) == 1
            let position = json["position"] as? String ?? ""
        self.init(nameImage: nameImage, userName: username, status: status, position: position)
        }
}

class StartConversationController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    @IBOutlet weak var lbDash: UILabel!
    let colorDash = UIColor(rgb: 0x404245, alpha: 1.0)
    @IBOutlet weak var tableNameChat: UITableView!
    var usersBySection: [String: [UserModel]] = [:]
    var positions: [String] = ["Dispatchers", "Drivers"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorView
        lbDash.backgroundColor = colorDash
        title = "Start a Conversation"
        if let navigationBar = navigationController?.navigationBar {
                navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 20)!
                ]
        }
        self.tableNameChat.backgroundColor = colorView
        tableNameChat.reloadData()

        readJSONFile()
    }
    func readJSONFile() {
            let fileName = "users"
            let fileType = "json"
            if let path = Bundle.main.path( forResource: fileName, ofType: fileType ) {
                do {
                    let data = try Data(contentsOf: URL( fileURLWithPath: path ), options: .mappedIfSafe )
                    if let jsonObject = try JSONSerialization.jsonObject(
                        with: data,
                        options: .mutableLeaves ) as? [String: Any],
                       let data = jsonObject["data"] as? [String: Any] {
                        usersBySection.removeAll()
                        if let dispatchersArray = data["dispatchers"] as? [[String: Any]] {
                            usersBySection["Dispatchers"] = dispatchersArray.map { UserModel(json: $0) }
                        }
                        if let driversArray = data["drivers"] as? [[String: Any]] {
                            usersBySection["Drivers"] = driversArray.map {
                                UserModel(json: $0 )
                            }
                        }
                        tableNameChat.reloadData( )
                    }
                } catch {
                    print( "Error reading JSON file: \( error ) " )
                }
            }
        }
}
