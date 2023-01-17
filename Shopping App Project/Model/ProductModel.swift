//
//  ProductModel.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 16.01.23.
//

import Foundation

struct ProductModel: Codable {
    var products: [Product]
}


struct Product: Codable {
    var title: String
    var price: Int
    var stock: Int
    var brand: String
    var category: String
    var thumbnail: String
}
