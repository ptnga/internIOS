import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgDoc4: UIImageView!
    @IBOutlet weak var imgDoc3: UIImageView!
    @IBOutlet weak var imgDoc2: UIImageView!
    @IBOutlet weak var imgDoc1: UIImageView!
    @IBOutlet weak var lbTimeDispatchNote: UILabel!
    @IBOutlet weak var lbDispatchNote: UILabel!
    @IBOutlet weak var lbTimeYouNote: UILabel!
    @IBOutlet weak var lbYouNote: UILabel!
    @IBOutlet weak var lbDeliveryNotes: UILabel!
    @IBOutlet weak var lbDropOff: UILabel!
    @IBOutlet weak var lbChange: UILabel!
    @IBOutlet weak var lbCustomPay: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbTip: UILabel!
    @IBOutlet weak var lbDiscounts: UILabel!
    @IBOutlet weak var lbPromo: UILabel!
    @IBOutlet weak var lbDeliveryFee: UILabel!
    @IBOutlet weak var lbTaxes: UILabel!
    @IBOutlet weak var lbSubtotal: UILabel!
    @IBOutlet weak var lbItemzSwerve: UILabel!
    @IBOutlet weak var lbNoteEight: UILabel!
    @IBOutlet weak var lbItemEight: UILabel!
    @IBOutlet weak var lbPaymet: UILabel!
    @IBOutlet weak var lbItemReward: UILabel!
    @IBOutlet weak var viewEightNote: UIView!
    @IBOutlet weak var viewYouNote: UIView!
    @IBOutlet weak var viewDispatchNote: UIView!
    
    let colorLetter = UIColor(rgb: 0xd6d6d7, alpha: 1.0)
    let colorViewNote = UIColor(rgb: 0x37373b, alpha: 1.0)
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func set(detailItem: ItemModel){
        lbPaymet.text = detailItem.paymet
        lbItemEight.text = detailItem.itemEight
        lbNoteEight.attributedText = createAttributedText(text: detailItem.noteEight)
        lbItemzSwerve.text = detailItem.itemSwerve
        lbItemReward.text = detailItem.reward
        lbSubtotal.text = ("\(detailItem.subtotal)")
        lbTaxes.text = ("\(detailItem.taxes)")
        lbDeliveryFee.text = ("\(detailItem.delivery)")
        lbPromo.text = ("\(detailItem.promo)")
        lbDiscounts.text = ("\(detailItem.discounts)")
        lbTip.text = ("\(detailItem.tip)")
        lbTotal.text = ("\(detailItem.total)")
        lbCustomPay.text = ("\(detailItem.custompay)")
        lbChange.text = ("\(detailItem.change)")
        lbDropOff.text = detailItem.dropoff
        lbDeliveryNotes.text = detailItem.deliveryNote
        lbYouNote.text = detailItem.youNote
        lbTimeYouNote.text = formatTimestamp(detailItem.timeYouNote)
        lbDispatchNote.text = detailItem.dispatchNote
        lbTimeDispatchNote.text = formatTimestamp(detailItem.timeDispatchNote)
        imgDoc1.image = UIImage(named: detailItem.customerDocument)
        imgDoc2.image = UIImage(named: detailItem.customerDocument)
        imgDoc3.image = UIImage(named: detailItem.customerDocument)
        imgDoc4.image = UIImage(named: detailItem.customerDocument)
        cornerRadiusView(view: viewYouNote)
        cornerRadiusView(view: viewEightNote)
        cornerRadiusView(view: viewDispatchNote)
    }
    
    private func formatTimestamp(_ timestamp: Int) -> String? {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a MMM dd, yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: date)
    }
    func createAttributedText(text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let fontMediumItalic = UIFont(name: "AvenirNext-MediumItalic", size: 16)!
        let fontRegular = UIFont(name: "AvenirNext-Regular", size: 16)!
        let fontDemiBold = UIFont(name: "AvenirNext-DemiBoldItalic", size: 16)!
        
        let fromCustomerRange = (text as NSString).range(of: "^ From Customer:")
        let regularTextRange = (text as NSString).range(of: "Please seperate bags by the eighth. You can call me as...")
        let moreTextRange = (text as NSString).range(of: "More")
        // Áp dụng thuộc tính cho từng phần
        attributedString.addAttribute(.font, value: fontMediumItalic, range: fromCustomerRange)
        attributedString.addAttribute(.foregroundColor, value: colorLetter, range: fromCustomerRange)
            
        attributedString.addAttribute(.font, value: fontRegular, range: regularTextRange)
        attributedString.addAttribute(.foregroundColor, value: colorLetter, range: regularTextRange)
            
        attributedString.addAttribute(.font, value: fontDemiBold, range: moreTextRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: moreTextRange)
            
        return attributedString
    }
    func cornerRadiusView(view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = colorViewNote.cgColor
    }
    
}
