//
//  CustomerCheckingViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 8/2/19.
//  Copyright © 2019 MI Apps. All rights reserved.
//

import UIKit
import Alamofire

class CustomerCheckingViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
 let URL_USER_REGISTER = "http://restaurantsbooker.de/customer_register.php";
    var passedValue: NSDictionary?
 
    @IBOutlet weak var txt_guestNumber: UITextField!
    
    @IBOutlet weak var txt_dateTime: UITextField!
    
    @IBOutlet weak var txt_mobile: UITextField!
    @IBOutlet weak var booking_label: UILabel!
    
    @IBOutlet weak var submit_button: UIButton!
    @IBAction func checking_action(_ sender: UIButton) {
        //creating parameters for the post request
        let parameters: Parameters=[
            "restaurant_name":passedValue!["restaurant_name"]!,
            "number_of_customers":txt_guestNumber.text!,
            "mobile":txt_mobile.text!,
            "date_time":txt_dateTime.text!,
            
        ]
        
        //Sending http post request
        AF.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    //displaying the message in label
                    self.booking_label.text = jsonData.value(forKey: "message") as! String?
                }
        }
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        txt_guestNumber.delegate = self
        txt_dateTime.delegate = self
        txt_mobile.delegate = self
       
        txt_guestNumber.autocorrectionType = .no
        txt_dateTime.autocorrectionType = .no
        txt_mobile.autocorrectionType = .no
        
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        
        let guestNumberText = txt_guestNumber.text ?? ""
        
        let dateTimeText = txt_dateTime.text ?? ""
        
        let mobileText = txt_mobile.text ?? ""
        
       
        submit_button.isEnabled = !guestNumberText.isEmpty && !dateTimeText.isEmpty && !mobileText.isEmpty 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        submit_button.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        
    }

}
