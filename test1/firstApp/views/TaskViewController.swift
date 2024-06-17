//
//  TaskViewController.swift
//  firstApp
//
//  Created by Bunn on 12/6/24.
//

import UIKit

class TaskViewController: UIViewController {
    let colorView = UIColor(rgb: 0x303034, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    func setupNavigationBar() {
        let switchButton = UISwitch()
        switchButton.isOn = true // Trạng thái mặc định là bật
        // Thêm switch button vào navigationItem
        self.navigationItem.titleView = switchButton
        navigationController!.navigationBar.barTintColor = colorView
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
        let rightButtonBar = UIBarButtonItem()
        rightButtonBar.customView = plusButtonView
        self.navigationItem.rightBarButtonItem = rightButtonBar
    }
}
