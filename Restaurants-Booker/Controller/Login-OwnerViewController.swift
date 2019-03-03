//
//  Login-OwnerViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 30/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit

class Login_OwnerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var username_textfield: UITextField!
    
    @IBOutlet weak var password_textfield: UITextField!
    
    @IBOutlet weak var login_button: UIButton!
 
    
    var owners = [Owner]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        username_textfield.delegate = self
        password_textfield.delegate = self
       
        username_textfield.autocorrectionType = .no
        password_textfield.autocorrectionType = .no
        
        updateLoginButtonState()
        
        if let savedOwners = loadOwners() {
            owners += savedOwners
        }
        
        
    }
    
    @IBAction func unwindToLoginView(segue: UIStoryboardSegue) {
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func isMatched() -> Bool {
        for owner in owners {
            
            if owner.password == password_textfield.text {
                
                return true
            }
        }
        return false
    }
    

    private func updateLoginButtonState() {
        
        let text = password_textfield.text ?? ""
        
        
        login_button.isEnabled = !text.isEmpty
    }
    
    private func loadOwners() -> [Owner]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Owner.ArchiveURL.path) as? [Owner]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        login_button.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButtonState()
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowOwnerHome" {
            
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

}
