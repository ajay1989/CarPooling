//
//  CarInfoVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 14/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
import IGColorPicker
class CarInfoVC: UIViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
     @IBOutlet weak var colorPickerView: ColorPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.isSelectedColorTappable = false
        colorPickerView.style = .circle //.square
        colorPickerView.selectionStyle = .check
        colorPickerView.backgroundColor = .clear
       // colorPickerView.layer.cornerRadius = 50
    }
    

    // MARK: - ColorPickerViewDelegate
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        //self.view.backgroundColor = colorPickerView.colors[indexPath.item]
    }
    
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 25, height: 25
        )
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

}
