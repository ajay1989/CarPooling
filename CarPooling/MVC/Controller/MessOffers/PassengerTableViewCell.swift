//
//  PassengerTableViewCell.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 02/02/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class PassengerTableViewCell: UITableViewCell {

    @IBOutlet weak var img_user: UIImageView!
    
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var btn_contact: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
