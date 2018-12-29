
//
//  Registration5VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 12/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
//88 182 157
class Registration5VC: BaseViewController,UITextFieldDelegate  {
    @IBOutlet weak var vw_number: UIView! {
        didSet {
            vw_number.layer.borderColor = UIColor(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
            vw_number.layer.borderWidth = 1.0
            vw_number.layer.cornerRadius = 20
            vw_number.layer.masksToBounds = true
        }
        
    }
    
    @IBOutlet weak var txt_dob: UITextField!
    @IBOutlet weak var btn_continue: UIButton!
    let selectedColor = UIColor.init(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0)
    @IBOutlet weak var btn_male: UIButton!
    var gender = "Male"
    var customDatePicker:ActionSheetStringPicker = ActionSheetStringPicker.init()
    let datePicker = UIDatePicker()
    @IBOutlet weak var btn_female: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        if (txt_dob.text?.isEmpty)! {
           self.continueDisable()
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btn_male_tap(_ sender: Any) {
        self.gender = "Male"
        self.btn_male.borderColor = selectedColor
        self.btn_female.borderColor = UIColor.darkGray
         self.btn_female.isSelected = false
        self.btn_male.isSelected = true
    }
    
    
    @IBAction func btn_continue_tap(_ sender: Any) {
        AppHelper.setStringForKey(self.txt_dob.text!, key: ServiceKeys.keyDOB)
        AppHelper.setStringForKey(self.gender, key: ServiceKeys.keyGender)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: Registration6VC = storyboard.instantiateViewController(withIdentifier: "Registration6VC") as! Registration6VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_female_tap(_ sender: Any) {
        self.gender = "Female"
        self.btn_male.borderColor = UIColor.darkGray
        self.btn_female.borderColor = selectedColor
        self.btn_female.isSelected = true
        self.btn_male.isSelected = false
    }
    
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
        
        txt_dob.inputAccessoryView = toolbar
        txt_dob.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txt_dob.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        self.continueEnable()
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
        if (self.txt_dob.text?.isEmpty)! {
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
}
