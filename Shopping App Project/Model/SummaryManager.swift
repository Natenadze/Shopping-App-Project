//
//  SummaryManager.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 20.01.23.
//

import Foundation


struct SummaryManager {
    
    static  var sumManager = SummaryManager()
    
    
    
    var title = [String]()
    var stock: Int = 0
    var price: Int = 0
    var quantity: Int = 0
    
    
    mutating func calculate(q: Int) {
        quantity += q
        
    }
    
    
}
