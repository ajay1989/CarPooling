//
//  CarInfoVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 14/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
import IGColorPicker
class CarInfoVC: UIViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout,UITextFieldDelegate {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    @IBOutlet weak var txt_number1: UITextField!
    
    @IBOutlet weak var txt_number2: UITextField!
    
    @IBOutlet weak var txt_number3: UITextField!
    @IBOutlet weak var txt_date: UITextField!
    @IBOutlet weak var btn_continue: UIButton!
     let datePicker = UIDatePicker()
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
        showDatePicker()
        if (txt_date.text?.isEmpty)! {
            self.continueDisable()
        }
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
    //MARK: Picker method
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txt_date.inputAccessoryView = toolbar
        txt_date.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txt_date.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        self.continueEnable()
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
        if (self.txt_date.text?.isEmpty)! {
            self.continueDisable()
        }
        else {
            self.continueEnable()
        }
    }
    func continueEnable() {
        btn_continue.isEnabled = true
        btn_continue.setTitle("Continue👉", for: .normal)
        btn_continue.setTitleColor(UIColor.black, for: .normal)
    }
    
    func continueDisable() {
        btn_continue.isEnabled = false
        btn_continue.setTitle("Continue👉🏼", for: .normal)
        btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
    }
    //MARK: TextField delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        
        if ( textField == txt_number1 )
       {
        if ( CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) && (textField.text?.count ?? 0  <= 4 ))
        {
            return true
        }
       
        
       else
        {
            return false
        }
       
        
        }
        if textField == txt_number2
        {
            if ( CharacterSet.uppercaseLetters.isSuperset(of: CharacterSet(charactersIn: string)) && (textField.text?.count ?? 0 <= 0 ) ) {
                return true
            }
            
            else
            {
                return false
            }
           
        }
        if textField == txt_number3
        {
            if ( CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) && (textField.text?.count ?? 0 <= 0 )) {
                return true
            }
            
            else
            {
                return false
            }
           
        }
        return false
        
    }
}
