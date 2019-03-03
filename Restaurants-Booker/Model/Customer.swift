//
//  Customer.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 29/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class Customer: NSObject, NSCoding {
    var restaurant_name: String
    var number_of_customers: String
    var mobile: String
    var date_time: Date
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("customers")
    //MARK: Types
    struct PropertyKey {
        static let restaurant_name = "restaurant_name"
        static let number_of_customers = "number_of_customers"
        static let mobile = "mobile"
        static let date_time = "date_time"
    }
    
    //MARK: Initialization
    init?(restaurant_name: String, number_of_customers: String, mobile: String, date_time: Date) {
        guard !restaurant_name.isEmpty else {
            return nil
        }
        guard !number_of_customers.isEmpty else {
            return nil
        }
        guard !mobile.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.restaurant_name = restaurant_name
        self.number_of_customers = number_of_customers
        self.mobile = mobile
        self.date_time = date_time
    }
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(restaurant_name, forKey: PropertyKey.restaurant_name)
        aCoder.encode(number_of_customers, forKey: PropertyKey.number_of_customers)
        aCoder.encode(mobile, forKey: PropertyKey.mobile)
        aCoder.encode(date_time, forKey: PropertyKey.date_time)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let restaurant_name = aDecoder.decodeObject(forKey: PropertyKey.restaurant_name) as? String else {
            os_log("Unable to decode the restaurant_name for a Customer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let number_of_customers = aDecoder.decodeObject(forKey: PropertyKey.number_of_customers) as? String else {
            os_log("Unable to decode the number_of_customers for a Customer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let mobile = aDecoder.decodeObject(forKey: PropertyKey.mobile) as? String else {
            os_log("Unable to decode the mobile for a Customer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let date_time = aDecoder.decodeObject(forKey: PropertyKey.date_time) as? Date else {
            os_log("Unable to decode the date_time for a Customer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(restaurant_name: restaurant_name, number_of_customers: number_of_customers, mobile: mobile, date_time: date_time)
        
    }
    
    

    
    
}
