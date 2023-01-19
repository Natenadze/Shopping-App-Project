//
//  SumCalculator.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 19.01.23.
//

import Foundation


struct SumCalculator {
    
    

    var quantity: Int = 0
    var price = 0
    let delivery = 50
    
    var vat: Int {
         (price * 9) / 100
    }
    
    var totalPrice: String {
        let sum = delivery + vat + price
        return String(sum)
    }
    
   
}
