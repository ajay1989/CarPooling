//
//  FilterVCViewController.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 21/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class FilterVCViewController: UIViewController {
    @IBOutlet weak var txt_date: UITextField!
    
    @IBOutlet weak var btn_male:UIButton!
    @IBOutlet weak var  btn_female:UIButton!
    @IBOutlet weak var vw_top:UIView!{
        didSet{
            vw_top.layer.shadowOffset = CGSize(width: 0, height: 3)
            vw_top.layer.shadowOpacity = 0.6
            vw_top.layer.shadowRadius = 3.0
            vw_top.layer.shadowColor = UIColor.lightGray.cgColor
        }
        
    }
    var customDatePicker:ActionSheetStringPicker = ActionSheetStringPicker.init()
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - Custom Action
    
    @IBAction func actionGoToBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionMale()
    {
        //
        btn_female.isSelected = false
        btn_female.borderColor = UIColor.gray
        btn_male.borderColor =  UIColor.init(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0)
        btn_male.isSelected = true
    }
    @IBAction func actionFemale()
    {
        btn_male.isSelected = false
        btn_male.borderColor = UIColor.gray
        btn_female.isSelected = true
        btn_female.borderColor =  UIColor.init(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0)
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.maximumDate  = Date()
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
        // self.continueEnable()
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
        if (self.txt_date
            .text?.isEmpty)! {
            // self.continueDisable()
        }
        else {
            // self.continueEnable()
        }
    }
}
