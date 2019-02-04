//
//  CarDetailsTableViewCell.swift
//  CarPooling
//
//  Created by archit rai saxena on 12/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit
import IGColorPicker
class CarDetailsTableViewCell: UITableViewCell,ColorPickerViewDelegateFlowLayout {

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
        var tempColor = [UIColor]()
        for data in appDelegate.arr_color {
            let col = hexStringToUIColor(hex: data.color_code!)
            tempColor.append(col)
        }

        
        self.carColorPickerView.layoutDelegate = self
        self.carColorPickerView.isSelectedColorTappable = false
        self.carColorPickerView.style = .circle //.square
        self.carColorPickerView.selectionStyle = .check
        self.carColorPickerView.colors =  tempColor
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 18, height: 18
        )
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

}
