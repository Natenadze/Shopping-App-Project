//
//  ConfirmationVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 18.01.23.
//

import UIKit

class ConfirmationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ShoppingPage
        destVC.quantityLabel.text = "0"
        destVC.sumPriceLabel.text = "0"
        destVC.finalQuantity = 0
        
        destVC.groupedItems.forEach { item in
            item.forEach { product in
                product.stock = product.remainingQuantity
                product.choosenQuantity = 0
            }
        }
        UserDefaults.standard.summary = nil
        UserDefaults.standard.busket = nil
        UserDefaults.standard.savedGroup = destVC.groupedItems
        
        destVC.tableView.reloadData()
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        
    }
}
