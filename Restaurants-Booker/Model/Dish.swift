//
//  Dish.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 30/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class Dish: NSObject, NSCoding {
    var name: String
    var price: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("dish")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let price = "price"
    }
    
    //MARK: Initialization
    
    init?(name: String, price: String) {
        
        
        guard !name.isEmpty else {
            return nil
        }
        guard !price.isEmpty else {
            return nil
        }
       
        // Initialize stored properties.
        self.name = name
        self.price = price
       
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(price, forKey: PropertyKey.price)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Dish object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let price = aDecoder.decodeObject(forKey: PropertyKey.price) as? String else {
            os_log("Unable to decode the price for a Dish object.", log: OSLog.default, type: .debug)
            return nil
        }
        
      
        
        
        // Must call designated initializer.
        self.init(name: name, price: price)
        
    }
}
