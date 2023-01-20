//
//  SummaryVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 18.01.23.
//

import UIKit

class SummaryVC: UIViewController {
  
    
   
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var itemTotalPrice: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var price = ""
    var total = ""
    var imageName = ""
    var titleName = ""
    var quantityName = ""
    var sumName = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceLabel.text! = price
        totalPriceLabel.text! = total
        navigationController?.navigationBar.isHidden = false
        
        tableView.register(UINib(nibName: "SummaryCell", bundle: nil), forCellReuseIdentifier: "sumCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
  
 
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func payPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "declined", sender: self)
        
    }

}


extension SummaryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sumCell", for: indexPath) as! SummaryCell
        cell.sumImage.image = UIImage(named: imageName)
        cell.titleLbl.text = titleName
        cell.quantityLbl.text = quantityName
        cell.sumLbl.text = sumName
        
        
        return cell
    }
    
   
    
    
    
}
