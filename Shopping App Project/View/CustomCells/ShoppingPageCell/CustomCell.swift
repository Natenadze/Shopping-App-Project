//
//  CustomCell.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit



protocol SummaryProtocol {
    func updateSummary(sum: Int, title: String, secNum: Int, rowNum: Int, image: String, isAdding: Bool)
  
    
}

class CustomCell: UITableViewCell {
    
    var delegate: SummaryProtocol? = nil
    var cancelTask: (() -> Void)?
    var imageURL: String = ""
    var section = 0
    var row = 0
    
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
    
   
    
    
    // MARK: - IBActions
    
    @IBAction func plusPressed(_ sender: UIButton) {
        let q = Int(chosenQuantityLabel.text!)! + 1
        let stock = Int(stockLabel.text!)!

        switch q {
        case stock + 1:
            return
        default:
            let _ = Int(priceLabel.text!)! * q
            delegate?.updateSummary(sum: Int(priceLabel.text!)!, title: titleLabel.text!, secNum: section, rowNum: row, image: imageURL, isAdding: true)

        }
        
    }
    @IBAction func minusPressed(_ sender: UIButton) {
        let q = Int(chosenQuantityLabel.text!)!

        switch q {
        case 0:
            return
        default:
            delegate?.updateSummary(sum: Int(priceLabel.text!)!, title: titleLabel.text!, secNum: section, rowNum: row, image: imageURL, isAdding: false)

        }
        
    }
}
