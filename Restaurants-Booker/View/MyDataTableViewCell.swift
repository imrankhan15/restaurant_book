//
//  MyDataTableViewCell.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 8/2/19.
//  Copyright © 2019 MI Apps. All rights reserved.
//

import UIKit

class MyDataTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurant_name: UILabel!
   
    @IBOutlet weak var owner_name: UILabel!
    @IBOutlet weak var mobile_number: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
