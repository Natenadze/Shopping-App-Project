//
//  ProductModel.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import UIKit

struct ProductModel: Codable {
    var products: [Product]
}


class Product: Codable {
    var title: String
    var price: Int
    var stock: Int
    var brand: String
    var category: String
    var thumbnail: String
    var choosenQuantity: Int! = 0
    var remainingQuantity: Int! {
        stock - choosenQuantity
    }
    var textColor: UIColor {
          return stock == 0 ? UIColor.red : UIColor.black
      }

    
}
