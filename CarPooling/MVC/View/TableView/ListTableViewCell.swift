//
//  ListTableViewCell.swift
//  CarPooling
//
//  Created by Ajay Vyas on 27/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var img_icon: UIImageView!
    @IBOutlet weak var lbl_text: UILabel!
    @IBOutlet weak var img_tick: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
