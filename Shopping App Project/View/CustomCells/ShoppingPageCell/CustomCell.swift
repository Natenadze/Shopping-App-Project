//
//  CustomCell.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit



protocol SummaryProtocol {
    func updateSummary(quantity: Int, sum: Int)
    func updateSumCellArrayPlusAction(info: SumCellInfo)
    func updateSumCellArrayMinusAction(info: SumCellInfo)
    
}

class CustomCell: UITableViewCell {
    
    var delegate: SummaryProtocol? = nil
    
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
        let q = Int(chosenQuantityLabel.text!)! + 1
        let stock = Int(stockLabel.text!)!
        
        
        switch q {
        case stock:
            return
        default:
            
            chosenQuantityLabel.text = String(q)
            let sum = Int(priceLabel.text!)! * q
            
            print(Int(priceLabel.text!)!,"and", q)
            print(sum)
            delegate?.updateSummary(quantity: 1, sum: Int(priceLabel.text!)!)
            delegate?.updateSumCellArrayPlusAction(info: SumCellInfo(image: productImage.image ?? UIImage(named: "scr")!,
                                                                     title: titleLabel.text!,
                                                                     quantity: chosenQuantityLabel.text!,
                                                                     subTotal: String(sum))
            )
        }
    }
    
    func minusUpdate() {
        let q = Int(chosenQuantityLabel.text!)!
        
        switch q {
        case 0:
            return
        default:
            chosenQuantityLabel.text = String(q - 1)
            delegate?.updateSummary(quantity: -1, sum: -Int(priceLabel.text!)!)
            delegate?.updateSumCellArrayMinusAction(info: SumCellInfo(image: productImage.image ?? UIImage(named: "scr")!,
                                                                      title: titleLabel.text!,
                                                                      quantity: chosenQuantityLabel.text!,
                                                                      subTotal: priceLabel.text!))
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
