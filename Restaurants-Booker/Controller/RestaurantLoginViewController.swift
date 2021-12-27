//
//  RestaurantLoginViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 11/2/19.
//  Copyright © 2019 MI Apps. All rights reserved.
//

import UIKit

class RestaurantLoginViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var restaurant_name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurant_name.delegate = self
        restaurant_name.autocorrectionType = .no 
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "bookingList") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! RestaurantBookingsTableViewController
            viewController.passedValue = restaurant_name.text
        }
    }
   
}
