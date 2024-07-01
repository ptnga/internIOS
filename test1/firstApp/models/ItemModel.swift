import Foundation
import UIKit

public final class ItemModel {
    var paymet: String
    var itemEight: String
    var noteEight: String
    var itemSwerve: String
    var reward: String
    var subtotal: Double
    var taxes: Double
    var delivery: Double
    var promo: Double
    var discounts: Double
    var tip: Double
    var total: Double
    var custompay: Double
    var change: Double
    var dropoff: String
    var deliveryNote: String
    var youNote: String
    var timeYouNote: Int
    var dispatchNote: String
    var timeDispatchNote: Int
    var customerDocument: String
    init(
        paymet: String,
        itemEight: String,
        noteEight: String,
        itemSwerve: String,
        reward: String,
        subtotal: Double,
        taxes: Double,
        delivery: Double,
        promo: Double,
        discounts: Double,
        tip: Double,
        total: Double,
        custompay: Double,
        change: Double,
        dropoff: String,
        deliveryNote: String,
        youNote: String,
        timeYouNote: Int,
        dispatchNote: String,
        timeDispatchNote: Int,
        customerDocument: String
    ) {
        self.paymet = paymet
        self.itemEight = itemEight
        self.noteEight = noteEight
        self.itemSwerve = itemSwerve
        self.reward = reward
        self.subtotal = subtotal
        self.taxes = taxes
        self.delivery = delivery
        self.promo = promo
        self.discounts = discounts
        self.tip = tip
        self.total = total
        self.custompay = custompay
        self.change = change
        self.dropoff = dropoff
        self.deliveryNote = deliveryNote
        self.youNote = youNote
        self.timeYouNote = timeYouNote
        self.dispatchNote = dispatchNote
        self.timeDispatchNote = timeDispatchNote
        self.customerDocument = customerDocument
    }
    convenience init(json: [String: Any]) {
        let paymet = json["paymet"] as? String ?? ""
        let itemEight = json["itemEight"] as? String ?? ""
        let noteEight = json["noteEight"] as? String ?? ""
        let itemSwerve = json["itemSwerve"] as? String ?? ""
        let reward = json["reward"] as? String ?? ""
        let subtotal = json["subtotal"] as? Double ?? 0.0
        let taxes = json["taxes"] as? Double ?? 0.0
        let delivery = json["delivery"] as? Double ?? 0.0
        let promo = json["promo"] as? Double ?? 0.0
        let discounts = json["discounts"] as? Double ?? 0.0
        let tip = json["tip"] as? Double ?? 0.0
        let total = json["total"] as? Double ?? 0.0
        let custompay = json["custompay"] as? Double ?? 0.0
        let change = json["change"] as? Double ?? 0.0
        let dropoff = json["dropoff"] as? String ?? ""
        let deliveryNote = json["deliveryNote"] as? String ?? ""
        let youNote = json["youNote"] as? String ?? ""
        let timeYouNote = (json["timeYouNote"] as? Int ?? 0)
        let dispatchNote = json["dispatchNote"] as? String ?? ""
        let timeDispatchNote = (json["timeDispatchNote"] as? Int ?? 0)
        let customerDocument = json["customerDocument"] as? String ?? ""
        
        self.init(
            paymet: paymet,
            itemEight: itemEight,
            noteEight: noteEight,
            itemSwerve: itemSwerve,
            reward: reward,
            subtotal: subtotal,
            taxes: taxes,
            delivery: delivery,
            promo: promo,
            discounts: discounts,
            tip: tip,
            total: total,
            custompay: custompay,
            change: change,
            dropoff: dropoff,
            deliveryNote: deliveryNote,
            youNote: youNote,
            timeYouNote: timeYouNote,
            dispatchNote: dispatchNote,
            timeDispatchNote: timeDispatchNote,
            customerDocument: customerDocument)
        }
}
