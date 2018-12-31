//
//  CreateNewOwnerViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 30/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class CreateNewOwnerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var restaurant_name: UITextField!
    @IBOutlet weak var submit_button: UIButton!
    
    var owners = [Owner]()
    var dishes = [Dish]()
    var owner: Owner?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        password.delegate = self
        userName.delegate = self
        mobile.delegate = self
        restaurant_name.delegate = self
        password.autocorrectionType = .no
        userName.autocorrectionType = .no
        mobile.autocorrectionType = .no
        restaurant_name.autocorrectionType = .no
        
        updateSaveButtonState()
        
        if let savedOwners = loadOwners() {
            owners += savedOwners
        }
    }
    

    private func updateSaveButtonState() {
        
        let text = password.text ?? ""
        
        let text1 = userName.text ?? ""
        
        let text2 = mobile.text ?? ""
        
        let text3 = restaurant_name.text ?? ""
        
        submit_button.isEnabled = !text.isEmpty && !text1.isEmpty && !text2.isEmpty && !text3.isEmpty
    }
    
    private func loadOwners() -> [Owner]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Owner.ArchiveURL.path) as? [Owner]
    }
    
    private func loadDishes() -> [Dish]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Dish.ArchiveURL.path) as? [Dish]
    }
    
    func isMatched() -> Bool {
        for owner in owners {
            
            if owner.password == password.text {
                
                return true
            }
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func done_action(_ sender: UIButton) {
        if isMatched(){
            
            let alertController = UIAlertController(title: "Password Already Exists", message: "Please Select Another Password", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
            
            
        }
        else {
            
            let username = self.userName.text!
            let password = self.password.text!
            let mobile = self.mobile.text!
            let restaurant_name = self.restaurant_name.text!
            
            if let saveddishes = loadDishes() {
                dishes += saveddishes            }
                
            else {
                
                
            }

            owner = Owner(username: username, password: password, restaurant_name: restaurant_name, mobile: mobile, dishes: dishes)
            
            owners.append(owner!)
            saveOwners()
            
            
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
    
    private func saveOwners() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(owners, toFile: Owner.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Owners successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save owners...", log: OSLog.default, type: .error)
        }
    }
    

}
