//
//  CustomCell.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit



protocol SummaryProtocol {
     func updateSummary(quantity: Int, sum: Int)
}

class CustomCell: UITableViewCell {
 
    
//    var sum = SummaryManager.sumManager
    var delegate: SummaryProtocol? = nil
    
//    var quantity: Int = 0
//    var price = 0
//
//
//    var vat: Int {
//         (price * 9) / 100
//    }
//
//    var totalPrice: Int {
//        let sum = price
//        return sum
//    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var chosenQuantityLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    

    func plusUpdate() {
        let q = Int(chosenQuantityLabel.text!)!
        let stock = Int(stockLabel.text!)!
        
        switch q {
        case stock: return
        default: chosenQuantityLabel.text = String(q + 1)
            delegate?.updateSummary(quantity: 1, sum: Int(priceLabel.text!)!)
        }
    }
    func minusUpdate() {
        let q = Int(chosenQuantityLabel.text!)!
        
        switch q {
        case 0:  return
        default: chosenQuantityLabel.text = String(q - 1)
            delegate?.updateSummary(quantity: -1, sum: -Int(priceLabel.text!)!)
        }
    }

    
    // MARK: - IBActions
    
    
    
    @IBAction func plusPressed(_ sender: UIButton) {
       plusUpdate()
        
   
    }
    @IBAction func minusPressed(_ sender: UIButton) {
     minusUpdate()
    }
    
    
}
