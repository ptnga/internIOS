import Foundation
import UIKit
class CustomNavigationBar {
    static func setupNavigationBar(
        navigationItem: UINavigationItem,
        navigationController: UINavigationController?,
        barTintColor: UIColor,
        leftButtonImageName: String,
        rightButtonImageName: String,
        leftFrameBT: CGRect,
        rightFrameBT: CGRect
    ) {
        let switchButton = UISwitch()
        switchButton.isOn = true
        navigationItem.titleView = switchButton
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: leftButtonImageName ),
            style: .plain,
            target: self,
            action: nil
        )
        let menuButtonView = UIButton(type: .custom)
        menuButtonView.setImage(UIImage(named: leftButtonImageName )?.withRenderingMode( .alwaysOriginal ), for: .normal)
        menuButtonView.clipsToBounds = true
        menuButtonView.contentVerticalAlignment = .fill
        menuButtonView.contentHorizontalAlignment = .fill
        menuButtonView.frame = leftFrameBT
        let lefttButtonBar = UIBarButtonItem()
        lefttButtonBar.customView = menuButtonView
        navigationItem.leftBarButtonItem = lefttButtonBar
        let mapButtonView = UIButton( type: .custom)
        mapButtonView.setImage(UIImage( named: rightButtonImageName )?.withRenderingMode( .alwaysOriginal ), for: .normal )
        mapButtonView.clipsToBounds = true
        mapButtonView.contentVerticalAlignment = .fill
        mapButtonView.contentHorizontalAlignment = .fill
        mapButtonView.frame = rightFrameBT
        let rightButtonBar = UIBarButtonItem()
        rightButtonBar.customView = mapButtonView
        navigationItem.rightBarButtonItem = rightButtonBar
    }
}
