import UIKit

class ChatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     var users: [ChatModel] = []
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    let colorDelete = UIColor(rgb: 0xED6348, alpha: 1.0)
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorView
        setupNavigationBar()
        setupTableView()
        view.applyKerning(1)
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
    func setupNavigationBar() {
        CustomNavigationBar.setupNavigationBar(
            navigationItem: self.navigationItem,
            navigationController: self.navigationController,
            barTintColor: .black,
            leftButtonImageName: "menuIcon",
            rightButtonImageName: "plusIcon",
            leftFrameBT: CGRect(x: 0, y: 0, width: 34, height: 34),
            rightFrameBT: CGRect(x: 0, y: 0, width: 22, height: 18)
        )
    }
    func setupTableView() {
        tableView.backgroundColor = colorView
        let nib = UINib(nibName: "ChatsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChatsTableViewCell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    func readJSONFile() {
        if let jsonObject = ReadFileJson().readJsonFile(named: "chat", ofType: "json") {
            users.removeAll()
            if let jsonData = jsonObject["data"] as? [[String: Any]] {
                users.removeAll()
                for json in jsonData {
                    let chatModel = ChatModel(json: json)
                    users.append(chatModel)
                }
                tableView.reloadData()
            }
        }
    }
}
extension ChatsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatsTableViewCell", for: indexPath) as! ChatsTableViewCell
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
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, handler) in
            // Xử lý khi nút delete được bấm
            print("Delete")
            handler(true)
        }
        // Tùy chỉnh màu nền của nút delete
        deleteAction.backgroundColor = colorDelete
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
    }
}
