//
//  customCellStartChat.swift
//  firstApp
//
//  Created by Bunn on 28/5/24.
//

import Foundation
import UIKit

class MyCellName: UITableViewCell {

    @IBOutlet weak var lbBorder: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbImage: UILabel!
    
    let colorBackgroundImage = UIColor(rgb: 0xFAD6DA, a: 1.0)
    let colorBorder =  UIColor(rgb: 0x5DE64E, a: 1.0)
    let colorFont = UIColor(rgb: 0xE65154, a: 1.0)
    let colorView = UIColor(rgb: 0x303034, a: 1.0)
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbName.translatesAutoresizingMaskIntoConstraints = false
        lbStatus.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
       
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraint for lbName
            lbName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 97),
            lbName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Constraint for lbStatus
            lbStatus.leadingAnchor.constraint(equalTo: lbName.trailingAnchor, constant: 15),
            lbStatus.centerYAnchor.constraint(equalTo: lbName.centerYAnchor),
            lbStatus.widthAnchor.constraint(equalToConstant: 9),
            lbStatus.heightAnchor.constraint(equalToConstant: 9),
            lbStatus.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
       
    
    public func set(user :UserModel){
        lbBorder.layer.backgroundColor = nil
        lbBorder.layer.borderColor = colorView.cgColor
        lbBorder.layer.borderWidth = 1
        lbBorder.layer.cornerRadius = lbBorder.frame.height/2
        lbBorder.layer.masksToBounds = true
    
        
        lbImage.text = user.nameImage
        lbImage.applyKerningLabel(1.3)
        
        lbImage.layer.cornerRadius = lbImage.frame.height/2
        lbImage.layer.masksToBounds = true
        lbImage.layer.borderWidth = 1
        lbImage.layer.backgroundColor = colorBackgroundImage.cgColor
        lbImage.layer.borderColor = colorView.cgColor

        lbStatus.layer.cornerRadius = lbStatus.frame.height/2
        lbStatus.layer.masksToBounds = true
        lbStatus.layer.borderWidth = 1
        lbStatus.layer.borderColor = colorView.cgColor
        
        lbName.text = user.username
        lbName.applyKerningLabel(1.3)
        lbName.textColor = UIColor.white
        lbName.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbName.sizeToFit()
        
        lbStatus.sizeToFit()
        
        if(user.status == true){
            lbBorder.layer.borderColor = colorBorder.cgColor
            
            
            lbStatus.layer.borderColor = UIColor.green.cgColor
            lbStatus.layer.backgroundColor = UIColor.green.cgColor
            
        }

    }
}

extension startConversationController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return positions.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return positions[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let positionKey = positions[section]
        return usersBySection[positionKey]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellName", for: indexPath) as! MyCellName
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

