//
//  customCell.swift
//  firstApp
//
//  Created by Bunn on 14/5/24.
//

import Foundation
import UIKit
extension View4Controller {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.backgroundColor = colorView
        
        let user = users[indexPath.row]
        cell.image1.image = UIImage(named: user.nameImage)
        cell.textView1a.text = user.username
        cell.textView1b.text = user.title
        cell.textView1c.text = user.timestamp
        cell.textView1c.applyKerning(1.3)
        
        if(user.numberNotify>0){
            cell.textView1a.textColor = UIColor.white
            
            cell.textView1b.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            cell.textView1b.textColor = UIColor.white
            
            cell.labelNotify.backgroundColor = .red
            cell.labelNotify.text = "\(user.numberNotify)"
            cell.labelNotify.layer.cornerRadius = cell.labelNotify.frame.height/2
            cell.labelNotify.layer.masksToBounds = true
            cell.labelNotify.layer.borderWidth = 1
            cell.labelNotify.layer.borderColor = UIColor.red.cgColor
        }
        
        return cell
    }
}

