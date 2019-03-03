//
//  Owner.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 29/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class Owner: NSObject, NSCoding {
    var username: String
    var password: String
    var restaurant_name: String
    var mobile: String
    var max_customer: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("owners")
    
    //MARK: Types
    struct PropertyKey {
        static let username = "username"
        static let password = "password"
        static let mobile = "mobile"
        
        static let restaurant_name = "restaurant_name"
        static let max_customer = "max_customer"
    }
    
    //MARK: Initialization
    init?(username: String, password: String, restaurant_name: String, mobile: String, max_customer: String) {
        guard !username.isEmpty else {
            return nil
        }
        guard !password.isEmpty else {
            return nil
        }
        guard !restaurant_name.isEmpty else {
            return nil
        }
        guard !mobile.isEmpty else {
            return nil
        }
        guard !max_customer.isEmpty else {
            return nil
        }
        // Initialize stored properties.
        self.username = username
        self.password = password
        self.mobile = mobile
        self.restaurant_name = restaurant_name
        self.max_customer = max_customer
    }

    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: PropertyKey.username)
        aCoder.encode(password, forKey: PropertyKey.password)
        aCoder.encode(mobile, forKey: PropertyKey.mobile)
        aCoder.encode(restaurant_name, forKey: PropertyKey.restaurant_name)
        aCoder.encode(max_customer, forKey: PropertyKey.max_customer)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let username = aDecoder.decodeObject(forKey: PropertyKey.username) as? String else {
            os_log("Unable to decode the name for a Owner object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let password = aDecoder.decodeObject(forKey: PropertyKey.password) as? String else {
            os_log("Unable to decode the email for a Owner object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let mobile = aDecoder.decodeObject(forKey: PropertyKey.mobile) as? String else {
            os_log("Unable to decode the mobile for a Owner object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let restaurant_name = aDecoder.decodeObject(forKey: PropertyKey.restaurant_name) as? String else {
            os_log("Unable to decode the restaurant for a Owner object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        guard let max_customer = aDecoder.decodeObject(forKey: PropertyKey.max_customer) as? String else {
            os_log("Unable to decode the max_customer for a Owner object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(username: username, password: password, restaurant_name: restaurant_name, mobile: mobile, max_customer: max_customer)
        
    }
}
