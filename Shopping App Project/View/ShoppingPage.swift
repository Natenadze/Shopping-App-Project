//
//  ShoppingPage.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit

class ShoppingPage: UIViewController {
    
    var items: ProductModel!
    
    var mainImage: UIImage?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.performURLRequest("https://dummyjson.com/products") { (data: ProductModel)  in
            self.items = data
        }
        performRequestForPosts(urlString: "https://i.dummyjson.com/data/products/6/thumbnail.png")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Did Appear")
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        navigationController?.navigationBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func performRequestForPosts(urlString: String) {
        let url = URL(string: urlString)!
       
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
            }
            guard let data else {return}
            self.mainImage = UIImage(data: data)
        }.resume()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
      
    }
    
    
}

extension ShoppingPage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return items.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        
        cell.titleLabel.text = items.products[indexPath.row].title
        cell.stockLabel.text = String(items.products[indexPath.row].stock)
        cell.priceLabel.text = String(items.products[indexPath.row].price)
        cell.productImage.image = mainImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        header.backgroundColor = .white
        let image = UIImageView(image: UIImage(named: "logo"))
        image.contentMode = .scaleAspectFit
        header.addSubview(image)
        image.frame = CGRect(x: 0, y: 5, width: header.frame.size.width, height: 100)

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    
    
    
}
