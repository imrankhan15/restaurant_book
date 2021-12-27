//
//  RestaurantBookingsTableViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 11/2/19.
//  Copyright © 2019 MI Apps. All rights reserved.
//

import UIKit
import Alamofire

class RestaurantBookingsTableViewController: UITableViewController {
    
    @IBOutlet var myTable: UITableView!
    var data_found = 0;
    var dbData: [NSDictionary]?
    var passedValue: String?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global(qos: .background).async {
            guard let endpoint = URL(string: "http://restaurantsbooker.de/sorted_bookings.php" ) else {
                print("Error creating connection")
                return
            }
            
            let parameters: Parameters=[
                "restaurant_name":self.passedValue!,
                
                
            ]
            AF.request(endpoint, method: .post, parameters: (parameters ), encoding: URLEncoding.default, headers: nil)
                .responseJSON { (response:DataResponse<Any>) in
                    
                    switch(response.result) {
                    case .success(_):
                        if let data = response.result.value as? [[String : AnyObject]] {
                            print(data)
                            self.dbData = data as [NSDictionary]
                            DispatchQueue.main.async {
                                self.data_found = 1
                                self.tableView.reloadData()
                            }
                            
                            
                            
                        }
                        else {
                            print(response.result.description)
                        }
                        break
                        
                    case .failure(_):
                        print(response.result.error)
                        break
                        
                    }
                    
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if data_found == 0 {
            return 0
        }
        else {
            return (dbData?.count)!
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as? RestaurantBookingTableViewCell ?? RestaurantBookingTableViewCell(style: .default, reuseIdentifier: "mycell")
        
        
        // Configure the cell...
        let row = indexPath.row
        
        let rowData = (dbData?[row])! as NSDictionary
        cell.number_of_customers.text = rowData["number_of_customers"] as? String
        cell.date_time.text = rowData["date_time"] as? String
        cell.reference_mobile.text = rowData["mobile"] as? String
        return cell
    }
}
