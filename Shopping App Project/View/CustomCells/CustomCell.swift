//
//  CustomCell.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit



protocol SummaryProtocol {
     func updateSummary(quantity: String, sum: String)
}

class CustomCell: UITableViewCell {
 
    
    
    var delegate: SummaryProtocol? = nil
    
    var quantity: Int = 0
    var price = 0
    var delivery = 50
    
    var vat: Int {
         (price * 9) / 100
    }
    
    var totalPrice: String {
        let sum = delivery  + price
        return String(sum)
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var chosenQuantityLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - IBActions
    
    
    
    @IBAction func plusPressed(_ sender: UIButton) {
        
        let stock = Int(stockLabel.text!)!
        if quantity < stock {
            quantity += 1
            delivery = 50
            price += Int(priceLabel.text!)!
            chosenQuantityLabel.text = String(quantity)
        }
        delegate?.updateSummary(quantity: "\(quantity)x", sum: totalPrice + "$")
       
        
    }
    @IBAction func minusPressed(_ sender: UIButton) {
       print(delivery)
        if quantity == 0 {
            delivery = 0
        }else {
            quantity -= 1
            price -= Int(priceLabel.text!)!
            chosenQuantityLabel.text = String(quantity)
        }
        delegate?.updateSummary(quantity: "\(quantity)x", sum: totalPrice + "$")
        
    }
    
    
}
