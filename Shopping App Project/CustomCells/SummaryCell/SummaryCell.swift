//
//  SummaryCell.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 20.01.23.
//

import UIKit

class SummaryCell: UITableViewCell {
    
    @IBOutlet weak var sumImage: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var sumLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 15.0
        self.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
