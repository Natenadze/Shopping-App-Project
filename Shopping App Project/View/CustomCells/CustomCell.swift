//
//  CustomCell.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var quantity = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var chosenQuantityLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - IBActions
    
    @IBAction func plusPressed(_ sender: UIButton) {
        quantity += 1
        chosenQuantityLabel.text = String(quantity)
        
    }
    @IBAction func minusPressed(_ sender: UIButton) {
        if quantity == 0 {
            return
        }else {
            quantity -= 1
            chosenQuantityLabel.text = String(quantity)
        }
    
        
    }
    
    
}
