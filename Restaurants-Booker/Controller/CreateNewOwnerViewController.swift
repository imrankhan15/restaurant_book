//
//  CreateNewOwnerViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 30/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log
import Alamofire

class CreateNewOwnerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
 let URL_USER_REGISTER = "http://restaurantsbooker.de/owner_register.php";
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var maximum_customer_number: UITextField!
    @IBOutlet weak var restaurant_name: UITextField!
    @IBOutlet weak var submit_button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        password.delegate = self
        userName.delegate = self
        mobile.delegate = self
        restaurant_name.delegate = self
        maximum_customer_number.delegate = self
        password.autocorrectionType = .no
        userName.autocorrectionType = .no
        mobile.autocorrectionType = .no
        restaurant_name.autocorrectionType = .no
        maximum_customer_number.autocorrectionType = .no
        updateSaveButtonState()
    }
    

    private func updateSaveButtonState() {
        
        let passwordText = password.text ?? ""
        
        let userNameText = userName.text ?? ""
        
        let mobileText = mobile.text ?? ""
        
        let restaurantNameText = restaurant_name.text ?? ""
        
        let customerNumberText = maximum_customer_number.text ?? ""
        
        submit_button.isEnabled = !passwordText.isEmpty && !userNameText.isEmpty && !mobileText.isEmpty && !restaurantNameText.isEmpty && !customerNumberText.isEmpty
    }
    
    
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func done_action(_ sender: UIButton) {
        
        //creating parameters for the post request
        let parameters: Parameters=[
            "username":userName.text!,
            "password":password.text!,
            "restaurant_name":restaurant_name.text!,
            "mobile":mobile.text!,
            "maximum_customer_number":maximum_customer_number.text!
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
                    self.label.text = jsonData.value(forKey: "message") as! String?
                }
        }
        
            
       
        
        
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
