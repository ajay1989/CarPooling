//
//  ComentsTableViewCell.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 04/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class ComentsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLikeDislike: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
