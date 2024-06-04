import UIKit

class StartConversationController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    let colorDash = UIColor(rgb: 0x404245, alpha: 1.0)
    @IBOutlet private weak var lbDash: UILabel!
    @IBOutlet private weak var tableNameChat: UITableView!
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
        setupTable()
        readJSONFile()
    }
    func setupTable() {
        let nib = UINib(nibName: "StartChatTableViewCell", bundle: nil)
        tableNameChat.register(nib, forCellReuseIdentifier: "StartChatTableViewCell")
        self.tableNameChat.backgroundColor = colorView
        tableNameChat.reloadData()
    }
    func readJSONFile() {
        if let jsonObject = ReadFileJson().readJsonFile(named: "users", ofType: "json") {
            usersBySection.removeAll()
            
            if let data = jsonObject["data"] as? [String: Any] {
                if let dispatchersArray = data["dispatchers"] as? [[String: Any]] {
                    usersBySection["Dispatchers"] = dispatchersArray.map { UserModel(json: $0) }
                }
                
                if let driversArray = data["drivers"] as? [[String: Any]] {
                    usersBySection["Drivers"] = driversArray.map { UserModel(json: $0) }
                }
            }
            
            tableNameChat.reloadData()
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
