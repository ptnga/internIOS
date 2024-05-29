import UIKit

class View3Controller: UIViewController {
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var counter: UILabel!
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    let colorView2 = UIColor(rgb: 0xFF8000, alpha: 0.53)
    var startTime: Date?
    var scheduledTimer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorView
        startTime = Date()
        UserDefaults.standard.set(startTime, forKey: "startTime")
        startTimer()
        // Do any additional setup after loading the view.
    }
    func startTimer() {
            scheduledTimer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(updateTimer),
                userInfo: nil,
                repeats: true)
    }
    @objc func updateTimer() {
        if let startTime = startTime {
            let currentTime = Date()
            let elapsedTime = currentTime.timeIntervalSince(startTime)
            // let hours = Int(elapsedTime) / 3600
            let minutes = Int( elapsedTime ) / 60 % 60
            let seconds = Int( elapsedTime ) % 60
            counter.text = String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
