//
//  DashboardTableViewCell.swift
//  CarPooling
//
//  Created by archit rai saxena on 20/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    @IBOutlet weak var vw_base: UIView!
    
    @IBOutlet weak var vw_green: UIView!
    
    @IBOutlet weak var lbl_fromDestination: UILabel!
    
    @IBOutlet weak var lbl_ToDestination: UILabel!
    
    @IBOutlet weak var lbl_timeFrom: UILabel!
    
    @IBOutlet weak var llbl_TimeTo: UILabel!
    
    @IBOutlet weak var lbl_userName: UILabel!
    
    @IBOutlet weak var lbl_seats: UILabel!
    
    @IBOutlet weak var lbl_Price: UILabel!
    
    @IBOutlet weak var img_user: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
