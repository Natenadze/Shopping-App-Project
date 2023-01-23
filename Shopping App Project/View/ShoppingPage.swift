//
//  ShoppingPage.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit


class ShoppingPage: UIViewController, SummaryProtocol {
    
    @IBOutlet weak var sumPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    var imageDictionary = [Int: UIImage]()
    
    var finalQuantity: Int! {
        Int(quantityLabel.text!.dropLast(1))!
    }
    
    var finalSubTotal: Int! {
        Int(sumPriceLabel.text!.dropLast(1))!
    }
    
    var items: [Product]!
    var groupedItems = [[Product]]()
    var sumInfoArray = [SumCellInfo]()
    
    
    // Saving data to UserDefaults
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        if let savedData = UserDefaults.standard.data(forKey: "products") {
            print("datacomes from the defaults")
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode([Product].self, from: savedData)
                self.items = products
                updateGroupedItems()
            } catch {
                print("Error decoding products from UserDefaults: \(error)")
            }
        } else {
            print("datacomes from the internet")
            NetworkManager.performURLRequest("https://dummyjson.com/products") { (data: ProductModel)  in
                self.items = data.products
                do {
                    let encoder = JSONEncoder()
                    let encodedData = try encoder.encode(self.items)
                    UserDefaults.standard.set(encodedData, forKey: "products")
                } catch {
                    print("Error encoding products to save to UserDefaults: \(error)")
                }
                self.updateGroupedItems()
            }
        }
    }
    
  

    override func viewDidAppear(_ animated: Bool) {
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func updateGroupedItems() {
        let dict = Dictionary(grouping: self.items, by: {$0.category})
        let keys = dict.keys.sorted()
        DispatchQueue.main.async {
            keys.forEach { item in
                dict[item]?.forEach({ Product in
                    Product.choosenQuantity = 0
                })
                self.groupedItems.append(dict[item]!)
            }
        }
    }
    
    func updateSummary(quantity: Int, sum: Int, title: String)  {
        quantityLabel.text = String(finalQuantity + quantity) + "x"
        sumPriceLabel.text = String(finalSubTotal + sum) + "$"
        for i in 0..<groupedItems.count {
            groupedItems[i].forEach { item in
                if item.title == title {
                    item.choosenQuantity! += quantity
                }
            }
        }
    }
    
    func updateSumCellArrayPlusAction(info: SumCellInfo) {
        if sumInfoArray.isEmpty {
            sumInfoArray.append(info)
        }else {
            var found = false
            for num in 0..<sumInfoArray.count {
                if sumInfoArray[num].title == info.title {
                    sumInfoArray[num].quantity = String(Int(sumInfoArray[num].quantity)! + 1)
                    sumInfoArray[num].subTotal = info.subTotal
                    found = true
                    break
                }
            }
            if !found {
                sumInfoArray.append(info)
            }
        }
    }
    
    
    func updateSumCellArrayMinusAction(info: SumCellInfo) {
        for num in 0..<sumInfoArray.count {
            if sumInfoArray[num].title == info.title {
                if sumInfoArray[num].quantity == "1" {
                    sumInfoArray.remove(at: num)
                } else {
                    sumInfoArray[num].quantity = String(Int(sumInfoArray[num].quantity)! - 1)
                    sumInfoArray[num].subTotal = String(Int(sumInfoArray[num].subTotal)! - Int(info.subTotal)!)
                }
                break
            }
        }
    }
    
    func sumCalc() -> Calc {
        var vat: Int {
            Int(Double(finalSubTotal) * 0.21)
        }
        var delivery = 50
        if vat == 0 {
            delivery = 0
        }
        var total: String {
            String(finalSubTotal! + Int(vat) + delivery)
        }
        
        return Calc(totalPrice: String(finalSubTotal!), vat: String(vat), delivery: String(delivery), total: total)
    }
    
    @IBAction func unwindToShoppingVC(_ sender: UIStoryboardSegue) {}
    
    @IBAction func goToSummary(_ sender: UIButton) {
        let summaryVC = storyboard?.instantiateViewController(withIdentifier: "summaryVC") as! SummaryVC
        
        summaryVC.calc = sumCalc()
        summaryVC.cellInfo = sumInfoArray
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        
        cell.titleLabel.text = groupedItems[indexPath.section][indexPath.row].title
        cell.stockLabel.text = String(groupedItems[indexPath.section][indexPath.row].stock)
        cell.priceLabel.text = String(groupedItems[indexPath.section][indexPath.row].price)
        cell.chosenQuantityLabel.text = String(groupedItems[indexPath.section][indexPath.row].choosenQuantity!)
        cell.delegate = self
        
        let url = URL(string: groupedItems[indexPath.section][indexPath.row].thumbnail)!
        
        let task =  URLSession.shared.dataTask(with: url ) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    cell.productImage.image = UIImage(data: data)
                }
            }
        }
        task.resume()
        cell.cancelTask = {
            task.cancel()
        }
        
        
        return cell
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
