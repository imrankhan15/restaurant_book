//
//  RestaurantBookingTableViewCell.swift
//  Restaurants-Booker
//
//  Created by Muhammad Faisal Imran Khan on 11/2/19.
//  Copyright © 2019 MI Apps. All rights reserved.
//

import UIKit

class RestaurantBookingTableViewCell: UITableViewCell {

    @IBOutlet weak var number_of_customers: UILabel!
  
    @IBOutlet weak var date_time: UILabel!
    
    @IBOutlet weak var reference_mobile: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
