//
//  UserDef Extension.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 25.01.23.
//

import Foundation

extension UserDefaults {
    
    
    var busket: [SumCellInfo]? {
        get {
            if let data = object(forKey: "test") as? Data {
                let result = try? JSONDecoder().decode([SumCellInfo].self, from: data)
                return result
            }
            return nil
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            setValue(data, forKey: "test")
        }
       
    }
    
    var summary: Calc? {
        get {
            if let data = object(forKey: "test2") as? Data {
                let result = try? JSONDecoder().decode(Calc.self, from: data)
                return result
            }
            return nil
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            setValue(data, forKey: "test2")
        }
       
    }
    
    var grr: [[Product]]? {
        get {
            if let data = object(forKey: "test3") as? Data {
                let result = try? JSONDecoder().decode([[Product]].self, from: data)
                return result
            }
            return nil
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            setValue(data, forKey: "test3")
        }
       
    }
    
 
}
