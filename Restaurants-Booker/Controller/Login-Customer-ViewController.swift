//
//  Login-Customer-ViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 29/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit

class Login_Customer_ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var logIn: UIButton!
    
    var customers = [Customer]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.delegate = self
        password.delegate = self
        userName.autocorrectionType = .no
        password.autocorrectionType = .no
        
        updateLoginButtonState()
        
        if let savedCustomers = loadCustomers() {
            customers += savedCustomers
        }
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func isMatched() -> Bool {
        for customer in customers {
            
         /*   if customer.password == password.text {
                
                return true
            }*/
        }
        return false
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowHome" {
            
            if isMatched(){
                
                
                return true
            }
            else {
                
                let alertController = UIAlertController(title: "No Match", message: "Please Register", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                
                return false
            }
        }
        
        // by default, transition
        return true
        
    }

    
    private func updateLoginButtonState() {
        
        let passwordText = password.text ?? ""
        
        
        logIn.isEnabled = !passwordText.isEmpty
    }
    
    private func loadCustomers() -> [Customer]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Customer.ArchiveURL.path) as? [Customer]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        logIn.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButtonState()
        
    }
    
  

}
