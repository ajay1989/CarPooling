//
//  PassengerListTableViiewCell.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 02/02/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class PassengerListTableViiewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_description: UILabel!
    
    @IBOutlet weak var btn_confirm: UIButton!
    
    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
