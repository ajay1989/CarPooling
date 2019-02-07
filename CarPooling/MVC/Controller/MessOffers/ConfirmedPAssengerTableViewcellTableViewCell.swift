//
// ConfirmedPAssengerTableViewcell.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 08/02/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class ConfirmedPAssengerTableViewcell: UITableViewCell {

    @IBOutlet weak var img_userProfile: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var btn_confirmed: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
