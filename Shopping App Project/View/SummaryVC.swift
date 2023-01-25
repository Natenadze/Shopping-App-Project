//
//  SummaryVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 18.01.23.
//

import UIKit
import Kingfisher

class SummaryVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var itemTotalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var calc: Calc?
    var cellInfo: [SumCellInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Payment page"
        if let s = UserDefaults.standard.summary {
            calc = s
        }
        
        if let calc {
            priceLabel.text! = calc.totalPrice + "$"
            totalPriceLabel.text! = calc.total + "$"
            vatLabel.text! = calc.vat + "$"
            deliveryLabel.text = calc.delivery + "$"
        }

        navigationController?.navigationBar.isHidden = false
        
        tableView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellReuseIdentifier: "sumCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func payPressed(_ sender: UIButton) {
        let price = Int(priceLabel.text!.dropLast(1))!
        if price > 3000 {
            performSegue(withIdentifier: "declined", sender: self)
        }else {
            performSegue(withIdentifier: "success", sender: self)
        }
    }
}

extension SummaryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellInfo!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sumCell", for: indexPath) as! SummaryCell
        let url = URL(string: (cellInfo?[indexPath.row].image)!)
        
       
        cell.sumImage.kf.setImage(with: url)
        cell.titleLbl.text = cellInfo?[indexPath.row].title
        cell.quantityLbl.text = cellInfo?[indexPath.row].quantity
        cell.sumLbl.text = cellInfo?[indexPath.row].subTotal
        return cell
    }
 
}
