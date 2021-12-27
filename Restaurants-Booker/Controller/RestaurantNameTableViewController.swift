//
//  RestaurantNameTableViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 8/2/19.
//  Copyright © 2019 MI Apps. All rights reserved.
//

import UIKit
import Alamofire

class RestaurantNameTableViewController: UITableViewController {

    var data_found = 0;
    
    var dbData: [NSDictionary]?
    
    var valueToPass: NSDictionary?
    
    @IBOutlet var myTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global(qos: .background).async {
            guard let endpoint = URL(string: "http://restaurantsbooker.de/owner_sqlToJson.php" ) else {
                print("Error creating connection")
                return
            }
            AF.request(endpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value as? [NSDictionary] {
                        print(data)
                        self.dbData = data
                        DispatchQueue.main.async {
                            self.data_found = 1
                            self.tableView.reloadData()
                        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as? MyDataTableViewCell ?? MyDataTableViewCell(style: .default, reuseIdentifier: "mycell")
        
        
        // Configure the cell...
        let row = indexPath.row
        
        let rowData = (dbData?[row])! as NSDictionary
        cell.restaurant_name.text = rowData["restaurant_name"] as? String
        cell.owner_name.text = rowData["username"] as? String
        cell.mobile_number.text = rowData["mobile"] as? String
        
        
        return cell
    }
    

   

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegue(withIdentifier: "customer", sender: indexPath);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "customer") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! CustomerCheckingViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let row = indexPath.row
            
            let rowData = (dbData?[row])! as NSDictionary
            viewController.passedValue = rowData
        }
    }

}
