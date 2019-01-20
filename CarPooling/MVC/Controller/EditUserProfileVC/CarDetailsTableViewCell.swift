//
//  CarDetailsTableViewCell.swift
//  CarPooling
//
//  Created by archit rai saxena on 12/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit
import IGColorPicker
class CarDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_carName: UILabel!
    
    @IBOutlet weak var btn_Delete: UIButton!
    
    @IBOutlet weak var txt_number1: UITextField!
    
    @IBOutlet weak var txt_number2: UITextField!
    
    
    @IBOutlet weak var txt_number3: UITextField!
    
    @IBOutlet weak var txt_date: UITextField!
    
    
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var carColorPickerView: ColorPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
