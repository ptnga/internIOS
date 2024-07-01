import UIKit

class AllTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tasks: [TaskModel] = []
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var btAllTasks: UIButton!
    @IBOutlet weak var btTodayTask: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorView
        setupNavigationBar()
        setupTableView()
        readJSONFile()
        addBottomBorderToButton()
        btTodayTask.setTitle("Today's Task", for: .normal)
        btTodayTask.applyKerningToTitle(kernValue: 1)
        btAllTasks.setTitle("All Tasks", for: .normal)
        btAllTasks.applyKerningToTitle(kernValue: 1)
    }
    func setupNavigationBar() {
        CustomNavigationBar.setupNavigationBar(
            viewController: self,
            navigationItem: self.navigationItem,
            navigationController: self.navigationController,
            barTintColor: .black,
            leftButtonImageName: "menuIcon",
            rightButtonImageName: "map",
            leftFrameBT: CGRect(x: 0, y: 0, width: 36, height: 36),
            rightFrameBT: CGRect(x: 0, y: 0, width: 25.79, height: 19)
        )
    }
    func setupTableView() {
        tableView.backgroundColor = colorView
        let nib = UINib(nibName: "AllTasksTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AllTasksTableViewCell")
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    func readJSONFile() {
        if let jsonObject = ReadFileJson().readJsonFile(named: "tasks", ofType: "json") {
            tasks.removeAll()
            if let jsonData = jsonObject["data"] as? [[String: Any]] {
                tasks.removeAll()
                for json in jsonData {
                    let taskModel = TaskModel(json: json)
                    tasks.append(taskModel)
                }
                tableView.reloadData()
            }
        }
    }
    func addBottomBorderToButton() {
        let bottomBorder = CALayer()
        let borderWidth: CGFloat = 4.0
        bottomBorder.borderColor = UIColor.white.cgColor
        bottomBorder.frame = CGRect(x: 0, y: btTodayTask.frame.size.height - borderWidth, width: btTodayTask.frame.size.width, height: borderWidth)
        bottomBorder.borderWidth = borderWidth
        
        btTodayTask.layer.addSublayer(bottomBorder)
        btTodayTask.layer.masksToBounds = true
    }

}
extension AllTasksViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTasksTableViewCell", for: indexPath) as! AllTasksTableViewCell
        cell.backgroundColor = colorView
        let task = tasks[indexPath.row]
        cell.set(task: task)
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 140
    }
}
