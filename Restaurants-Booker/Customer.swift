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
    var username: String
    var password: String
    var mobile: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("customers")
    //MARK: Types
    struct PropertyKey {
        static let username = "username"
        static let password = "password"
        static let mobile = "mobile"
    }
    
    //MARK: Initialization
    init?(username: String, password: String, mobile: String) {
        guard !username.isEmpty else {
            return nil
        }
        guard !password.isEmpty else {
            return nil
        }
        guard !mobile.isEmpty else {
            return nil
        }
        // Initialize stored properties.
        self.username = username
        self.password = password
        self.mobile = mobile
    }
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: PropertyKey.username)
        aCoder.encode(password, forKey: PropertyKey.password)
        aCoder.encode(mobile, forKey: PropertyKey.mobile)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let username = aDecoder.decodeObject(forKey: PropertyKey.username) as? String else {
            os_log("Unable to decode the name for a Customer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let password = aDecoder.decodeObject(forKey: PropertyKey.password) as? String else {
            os_log("Unable to decode the email for a Customer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let mobile = aDecoder.decodeObject(forKey: PropertyKey.mobile) as? String else {
            os_log("Unable to decode the mobile for a Customer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(username: username, password: password, mobile: mobile)
        
    }
    
    

    
    
}
