//
//  NewCustomerViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 29/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log
class NewCustomerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userName: UITextField!
  
    @IBOutlet weak var password: UITextField!
   
    @IBOutlet weak var mobileNumber: UITextField!
    
    @IBOutlet weak var button_new_customer: UIButton!
    
    var customers = [Customer]()
    
    var customer: Customer?
    override func viewDidLoad() {
        super.viewDidLoad()

        password.delegate = self
        userName.delegate = self
        mobileNumber.delegate = self
        
        password.autocorrectionType = .no
        userName.autocorrectionType = .no
        mobileNumber.autocorrectionType = .no
        
        updateSaveButtonState()
        
        if let savedCustomers = loadCustomers() {
            customers += savedCustomers
        }
    }
    
    private func updateSaveButtonState() {
        
        let passwordText = password.text ?? ""
        
        let userNameText = userName.text ?? ""
        
        let mobileText = mobileNumber.text ?? ""
        
        button_new_customer.isEnabled = !passwordText.isEmpty && !userNameText.isEmpty && !mobileText.isEmpty
    }
    
    private func loadCustomers() -> [Customer]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Customer.ArchiveURL.path) as? [Customer]
    }
    
    func isMatched() -> Bool {
    
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func done_action(_ sender: UIButton) {
        if isMatched(){
            
            let alertController = UIAlertController(title: "Password Already Exists", message: "Please Select Another Password", preferredStyle: UIAlertController.Style.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
            
            
            
            // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
            
            
        }
        else {
            
           
            saveCustomers()
            if let owningNavigationController = navigationController{
                owningNavigationController.popViewController(animated: true)
            }
            else {
                fatalError("The LoginViewController is not inside a navigation controller.")
            }
        }
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        button_new_customer.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        
    }
    
    private func saveCustomers() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(customers, toFile: Customer.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Customers successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save customers...", log: OSLog.default, type: .error)
        }
    }
    

}
