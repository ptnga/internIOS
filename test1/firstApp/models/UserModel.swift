import Foundation
import UIKit

public final class UserModel {
    var nameImage: String
    var username: String
    var status: Bool
    var position: String
    // var numberStatus: Int
    init(nameImage: String, userName: String, status: Bool, position: String) {
        self.nameImage = nameImage
        self.username = userName
        self.status = status
        self.position = position
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
            let status = (json["status"] as? Int ?? 0) == 1
            let position = json["position"] as? String ?? ""
        self.init(nameImage: nameImage, userName: username, status: status, position: position)
        }
}
