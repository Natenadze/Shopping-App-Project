//
//  ShoppingPage.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit

//protocol Sum {
//    func summaryUpdate(price: String, total: String)
//}


struct Calc {
    var totalPrice: String
    var vat : String
    var delivery: String
    var total: String
}

class ShoppingPage: UIViewController, SummaryProtocol {

    

    @IBOutlet weak var sumPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
//    var delegate: Sum?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var finalQuantity: Int! {
       Int(quantityLabel.text!.dropLast(1))!
    }
    
    var finalSubTotal: Int! {
         Int(sumPriceLabel.text!.dropLast(1))!
    }
    
    var items: [Product]!
    var groupedItems = [[Product]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        NetworkManager.performURLRequest("https://dummyjson.com/products") { (data: ProductModel)  in
            self.items = data.products
            let dict = Dictionary(grouping: self.items, by: {$0.category})
            let keys = dict.keys
            DispatchQueue.main.async {
                keys.forEach { self.groupedItems.append(dict[$0]!) }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func updateSummary(quantity: Int, sum: Int)  {
         quantityLabel.text = String(finalQuantity + quantity) + "x"
         sumPriceLabel.text = String(finalSubTotal + sum) + "$"
    }
    
    func sumCalc() -> Calc {
        
        var vat: Int {
            Int(Double(finalSubTotal) * 0.21)
        }
        let delivery = 50
        var total: String {
            String(finalSubTotal! + Int(vat) + delivery)
        }


        return Calc(totalPrice: String(finalSubTotal!), vat: String(vat), delivery: String(delivery), total: total)
    }
    
  
    
    
    @IBAction func goToSummary(_ sender: UIButton) {
        let summaryVC = storyboard?.instantiateViewController(withIdentifier: "summaryVC") as! SummaryVC
        
        summaryVC.calc = sumCalc()
        
        
        navigationController?.pushViewController(summaryVC.self, animated: true)

    }
    
}

extension ShoppingPage: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        groupedItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groupedItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        cell.titleLabel.text = groupedItems[indexPath.section][indexPath.row].title
        cell.stockLabel.text = String(groupedItems[indexPath.section][indexPath.row].stock)
        cell.priceLabel.text = String(groupedItems[indexPath.section][indexPath.row].price)
        cell.delegate = self
//        URLSession.shared.dataTask(with: URL(string: groupedItems[indexPath.section][indexPath.row].thumbnail)!) { data, response, error in
//            if let data = data {
//                DispatchQueue.main.async {
//                    cell.imageView?.image = UIImage(data: data)
//                }
//            }
//        }.resume()
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    // MARK: - Header info
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        header.backgroundColor = .white
        if section == 0 {

            let image = UIImageView(image: UIImage(named: "logo"))
            image.contentMode = .scaleAspectFit
            header.addSubview(image)
            image.frame = CGRect(x: 0, y: 5, width: header.frame.size.width, height: 100)
            let label = UILabel(frame: CGRect(x: 5, y: 80,
                                              width: header.frame.size.width - 15,
                                              height: header.frame.size.height - 10))
            label.text = groupedItems[section][0].category
            label.font = .boldSystemFont(ofSize: 20)
            header.addSubview(label)

        }else {
            let label = UILabel(frame: CGRect(x: 5, y: 15,
                                              width: header.frame.size.width - 15,
                                              height: header.frame.size.height - 10))
            label.text = groupedItems[section][0].category
            label.font = .boldSystemFont(ofSize: 20)
            header.addSubview(label)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 150
        default: return 110
        }

    }
}
