//
//  SummaryVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 18.01.23.
//

import UIKit

class SummaryVC: UIViewController {
  
    
   
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var price = ""
    var total = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceLabel.text! = price
        totalPriceLabel.text! = total
        navigationController?.navigationBar.isHidden = false
        navigationController?.title = "Summary"
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
    
    
}
