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
    let colorDash = UIColor(rgb: 0x404245, alpha: 1.0)
    @IBOutlet weak var lbDash: UILabel!
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
        let nib = UINib(nibName: "StartChatTableViewCell", bundle: nil)
        tableNameChat.register(nib, forCellReuseIdentifier: "StartChatTableViewCell")
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
extension StartConversationController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return positions.count
    }
    func tableView( _ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return positions[section]
    }
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let positionKey = positions[section]
        return usersBySection[positionKey]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StartChatTableViewCell", for: indexPath) as! StartChatTableViewCell
        cell.backgroundColor = colorView
        let position = positions[indexPath.section]
        if let user = usersBySection[position]?[indexPath.row] {
            cell.set(user: user)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = colorView
            let label = UILabel()
            label.text = positions[section]
            label.applyKerningLabel(1.3)
            label.textColor = .white
            label.font = UIFont(name: "AvenirNext-DemiBold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(label)
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            return headerView
        }
}
