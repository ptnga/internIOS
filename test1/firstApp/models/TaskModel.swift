import Foundation
import UIKit

public final class TaskModel {
    var taskname: String
    var address: String
    var country: String
    var min: Int
    var timestamp: Int
    var distance: String
    init(taskname: String, address: String, country: String, min: Int, timestamp: Int, distance: String) {
        self.taskname = taskname
        self.address = address
        self.country = country
        self.min = min
        self.timestamp = timestamp
        self.distance = distance
    }
    convenience init(json: [String: Any]) {
        let taskname = json["taskname"] as? String ?? ""
        let address = json["address"] as? String ?? ""
        let country = json["country"] as? String ?? ""
        let min = (json["min"] as? Int ?? 0)
        let timestamp = (json["timestamp"] as? Int ?? 0)
        let distance = json["distance"] as? String ?? ""
        
        self.init(
            taskname: taskname,
            address: address,
            country: country,
            min: min,
            timestamp: timestamp,
            distance: distance
        )
        }
}
