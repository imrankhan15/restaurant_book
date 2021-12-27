//
//  DishListItemViewController.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 30/12/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class DishListItemViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cancel_button: UIBarButtonItem!
   
    @IBOutlet weak var save_button: UIBarButtonItem!
   
    @IBOutlet weak var dish_name: UITextField!
    
    @IBOutlet weak var dish_price: UITextField!
    
    var dish: Dish?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        dish_name.delegate = self
        dish_price.delegate = self
        
        dish_price.autocorrectionType = .no
        dish_name.autocorrectionType = .no
        updateSaveButtonState()
    }
    

    func isModal() -> Bool {
        if self.presentingViewController != nil {
            return true
        }
        
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private var wasPushed: Bool {
        guard let vc = navigationController?.viewControllers.first, vc == self else {
            return true
        }
        
        return false
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        
        let isPresentingInAddltemMode = wasPushed
        if !isPresentingInAddltemMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ItemViewController is not inside a navigation controller.")
        }
    }
    
    private func updateSaveButtonState() {
        
        let dishNameText = dish_name.text ?? ""
        
        let dishPriceText = dish_price.text ?? ""
        
        
        save_button.isEnabled = !dishNameText.isEmpty && !dishPriceText.isEmpty
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        save_button.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === save_button else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let dishName = dish_name.text ?? ""
        
        let dishPrice = dish_price.text ?? ""
        
        
        
        dish = Dish(name: dishName, price: dishPrice)
    }

}
