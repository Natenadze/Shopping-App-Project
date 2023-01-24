//
//  CustomCell.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit



protocol SummaryProtocol {
    func updateSummary(quantity: Int, sum: Int, title: String)
    func updateSumCellArrayPlusAction(info: SumCellInfo)
    func updateSumCellArrayMinusAction(info: SumCellInfo)
    
}

class CustomCell: UITableViewCell {
    
    var delegate: SummaryProtocol? = nil
    var cancelTask: (() -> Void)?
    var imageURL: String = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var chosenQuantityLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelTask?()
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
            delegate?.updateSummary(quantity: 1, sum: Int(priceLabel.text!)!, title: titleLabel.text!)
            delegate?.updateSumCellArrayPlusAction(info: SumCellInfo(image: imageURL,
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
            delegate?.updateSummary(quantity: -1, sum: -Int(priceLabel.text!)!, title: titleLabel.text!)
            delegate?.updateSumCellArrayMinusAction(info: SumCellInfo(image: "",
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
