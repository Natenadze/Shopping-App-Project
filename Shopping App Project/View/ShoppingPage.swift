//
//  ShoppingPage.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit

class ShoppingPage: UIViewController {
    
    var items: [Product]!
    var groupedItems = [[Product]]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.performURLRequest("https://dummyjson.com/products") { (data: ProductModel)  in
            self.items = data.products
            print(data.products)
            let dict = Dictionary(grouping: self.items, by: {$0.category})
            let keys = dict.keys
            DispatchQueue.main.async {
                keys.forEach { self.groupedItems.append(dict[$0]!) }
            }
            
          
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        navigationController?.navigationBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    @IBAction func goToSummary(_ sender: UIButton) {
        let summaryVC = storyboard?.instantiateViewController(withIdentifier: "summaryVC") as! SummaryVC
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
        
        URLSession.shared.dataTask(with: URL(string: groupedItems[indexPath.section][indexPath.row].thumbnail)!) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: data)
                }
            }
        }.resume()
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.gray.cgColor
//        cell.layer.cornerRadius = 10
////        cell.separatorInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
//    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    

    
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "asdasdkasjdnasd"
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 150
        default: return 110
        }
        
    }
}
