//
//  ShoppingPage.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit
import Kingfisher

class ShoppingPage: UIViewController, SummaryProtocol {
    
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var sumPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goToSumBtn: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [Product]!
    var groupedItems = [[Product]]()
    var sumInfoArray = [SumCellInfo]()
    var sumCalculation: SummaryCalculator?
    var imageDictionary = [Int: UIImage]()
    var finalQuantity = 0
    var finalSubTotal: Int! { Int(sumPriceLabel.text!) ?? 0 }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkCheck.shared.checkIt(presenter: self)
        navigationController?.navigationBar.isHidden = true
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        sumInfoArray =  UserDefaults.standard.busket ?? sumInfoArray
        sumCalculation = UserDefaults.standard.summary ?? nil
        groupedItems = UserDefaults.standard.savedGroup ?? groupedItems
        
        if let newGroup = UserDefaults.standard.savedGroup {
            groupedItems = newGroup
            sumPriceLabel.text = sumCalculation?.totalPrice ?? "0"
            finalQuantity = sumInfoArray.isEmpty ? 0 : sumInfoArray.reduce(0, { $0 + $1.quantity })
            quantityLabel.text = String(finalQuantity)
        }else {
            fillMainData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goToSumBtn.isEnabled = finalQuantity != 0
        
    }
    
    func fillMainData() {
        if let savedData = UserDefaults.standard.data(forKey: "products") {
            print("datacomes from the defaults")
            do {
                let products = try JSONDecoder().decode([Product].self, from: savedData)
                self.items = products
                updateGroupedItems()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding products from UserDefaults: \(error)")
            }
        } else {
            print("datacomes from the internet")
            NetworkManager.performURLRequest("https://dummyjson.com/products") { (data: ProductModel)  in
                self.items = data.products
                do {
                    let encodedData = try JSONEncoder().encode(self.items)
                    UserDefaults.standard.set(encodedData, forKey: "products")
                } catch {
                    print("Error encoding products to save to UserDefaults: \(error)")
                }
                self.updateGroupedItems()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
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
    
    func sumCalc() -> SummaryCalculator {
        var vat: Int {
            Int(Double(finalSubTotal!) * 0.21)
        }
        var delivery = 50
        delivery = vat == 0 ? 0 : 50
        var total: String {
            String(finalSubTotal! + Int(vat) + delivery)
        }
        return SummaryCalculator(totalPrice: String(finalSubTotal!), vat: String(vat), delivery: String(delivery), total: total)
    }
    
    // MARK: - Delegate Functions
    
    func updateSummary(sum: Int, title: String, secNum: Int, rowNum: Int, image: String, isAdding: Bool) {
        let item = SumCellInfo(image: image, title: title, quantity: 1, subTotal: sum)
        
        if isAdding {
            cartImageView.shake()
            cartImageView.image = UIImage(systemName: "cart.fill")
            let subtotal = finalSubTotal + sum
            finalQuantity += 1
            
            if sumInfoArray.isEmpty {
                sumInfoArray.append(item)
            }else {
                var found = false
                for num in 0..<sumInfoArray.count {
                    if sumInfoArray[num].title == item.title {
                        sumInfoArray[num].quantity = sumInfoArray[num].quantity + 1
                        sumInfoArray[num].subTotal = sumInfoArray[num].subTotal + sum
                        found = true
                        break
                    }
                }
                if !found {
                    sumInfoArray.append(item)
                }
            }
            quantityLabel.text = String(finalQuantity)
            sumPriceLabel.text = String(subtotal)
            groupedItems[secNum][rowNum].choosenQuantity += 1
            
        }
        
        if !isAdding {
            let subtotal1 = finalSubTotal - sum
            if subtotal1 == 0 {
                cartImageView.image = UIImage(systemName: "cart")
            }
            finalQuantity -= 1
            groupedItems[secNum][rowNum].choosenQuantity -= 1
            quantityLabel.text = String(finalQuantity - 1)
            sumPriceLabel.text = String(finalSubTotal - sum)
            for num in 0..<sumInfoArray.count {
                if sumInfoArray[num].title == item.title {
                    if sumInfoArray[num].quantity == 1 {
                        sumInfoArray.remove(at: num)
                    } else {
                        sumInfoArray[num].quantity =  sumInfoArray[num].quantity - 1
                        sumInfoArray[num].subTotal = sumInfoArray[num].subTotal - item.subTotal
                    }
                    break
                }
            }
            quantityLabel.text = String(finalQuantity )
            sumPriceLabel.text = String(subtotal1)
        }
        goToSumBtn.isEnabled = finalQuantity != 0
        updateSumCellArrayPlusAction()
    }
    
    func updateSumCellArrayPlusAction() {
        UserDefaults.standard.busket = sumInfoArray
        sumCalculation = sumCalc()
        UserDefaults.standard.savedGroup = groupedItems
        UserDefaults.standard.summary = sumCalculation
        tableView.reloadData()
    }
    
    @IBAction func goToSummary(_ sender: UIButton) {
        let summaryVC = storyboard?.instantiateViewController(withIdentifier: "summaryVC") as! SummaryVC
        summaryVC.calc = sumCalculation
        summaryVC.cellInfo = sumInfoArray
        navigationController?.pushViewController(summaryVC.self, animated: true)
    }
    
    @IBAction func unwindToShoppingVC(_ sender: UIStoryboardSegue) {
        self.dismiss(animated: false)
    }
}

// MARK: - Extension

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
        let currentItem = groupedItems[indexPath.section][indexPath.row]
        
        cell.titleLabel.text = currentItem.title
        cell.stockLabel.text = String(currentItem.stock)
        cell.priceLabel.text = String(currentItem.price)
        cell.chosenQuantityLabel.text = String(currentItem.choosenQuantity!)
        cell.imageURL = currentItem.thumbnail
        cell.section = indexPath.section
        cell.row = indexPath.row
        cell.delegate = self
        cell.titleLabel.textColor = currentItem.textColor
        let url = URL(string: currentItem.thumbnail)!
        cell.productImage.kf.setImage(with: url)
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
