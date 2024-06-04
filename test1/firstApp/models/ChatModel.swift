import Foundation
import UIKit

public final class ChatModel {
    var nameImage: String
    var username: String
    var position: String
    var title: String
    var timestamp: Int
    var numberNotify: Int
    var status: Bool
    init(nameImage: String, username: String, position: String, title: String, timestamp: Int, numberNotify: Int, status: Bool) {
        self.nameImage = nameImage
        self.username = username
        self.position = position
        self.title = title
        self.timestamp = timestamp
        self.numberNotify = numberNotify
        self.status = status
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
        let position = json["position"] as? String ?? ""
        let message = json["message"] as? String ?? ""
        let timestamp = (json["time"] as? Int ?? 0)
        let numberNotify = (json["numer_unread"] as? Int ?? 0)
        let status = (json["status"] as? Int ?? 0) == 1
        
        self.init(
            nameImage: nameImage,
            username: username,
            position: position,
            title: message,
            timestamp: timestamp,
            numberNotify: numberNotify,
            status: status
        )
        }
}
