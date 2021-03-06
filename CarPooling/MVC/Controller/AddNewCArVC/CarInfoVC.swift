//
//  CarInfoVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 14/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
import IGColorPicker
class CarInfoVC: BaseViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout,UITextFieldDelegate {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    var arr_cars:Car?
    var isFromEdit = false
    var isFromCarEdit = false
    @IBOutlet weak var txt_number1: UITextField!
     @IBOutlet weak var btn_brand: UIButton!
    var txt_brandName = "Hyndai i10"
    var txt_modelID = ""
    @IBOutlet weak var txt_number2: UITextField!
    var selectedColor = ""
    @IBOutlet weak var lbl_brandName: UILabel!
    var color:UIColor?
    @IBOutlet weak var txt_number3: UITextField!
    @IBOutlet weak var txt_date: UITextField!
    @IBOutlet weak var btn_continue: UIButton!
     let datePicker = UIDatePicker()
     @IBOutlet weak var colorPickerView: ColorPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_brandName.text = self.txt_brandName
        // Do any additional setup after loading the view.
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.isSelectedColorTappable = false
        colorPickerView.style = .circle //.square
        colorPickerView.selectionStyle = .check
        //colorPickerView.backgroundColor = .gray
        colorPickerView.backgroundColor = UIColor.init(red: (173/255.0), green: (191/255.0), blue: (192.0/255.0), alpha: 1.0)
        var tempColor = [UIColor]()
        for data in appDelegate.arr_color {
            let col = hexStringToUIColor(hex: data.color_code!)
            tempColor.append(col)
        }
        colorPickerView.colors = tempColor
       // colorPickerView.layer.cornerRadius = 50
        showDatePicker()
        if (txt_date.text?.isEmpty)! {
            self.continueDisable()
        }
        
        if isFromCarEdit {
            txt_number1.text = arr_cars?.vehicle_number_one!
            txt_date.text = arr_cars?.insurance_expire_date!
            txt_number2.text = arr_cars!.vehicle_number_two!
            txt_number3.text = arr_cars!.vehicle_number_three!
            lbl_brandName.text = arr_cars!.brand_name
            self.continueEnable()
            
            
        }
    }
    

    // MARK: - ColorPickerViewDelegate
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        let data = appDelegate.arr_color[indexPath.item]
        self.selectedColor = data.color_code!
        self.color  = colorPickerView.colors[indexPath.item]
    }
    
    @IBAction func btn_back_tap(_ sender: Any) {
        if self.isFromCarEdit {
            self.dismiss(animated: true) {
                
            }
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
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
        formatter.dateFormat = "MM-dd-yyyy"
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
        btn_continue.setTitle("Continuer👉", for: .normal)
        btn_continue.setTitleColor(UIColor.black, for: .normal)
    }
    
    func continueDisable() {
        btn_continue.isEnabled = false
        btn_continue.setTitle("Continuer👉🏼", for: .normal)
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
            if (string != ""){
            if ( CharacterSet.letters.isSuperset(of: CharacterSet(charactersIn: string)) && (textField.text?.count ?? 0 <= 0 ) ) {
                return true
            }
            
            else
            {
                return false
            }
            }
            else
            {
            return true
            }
           
        }
        if textField == txt_number3
        {
             if (string != ""){
            if ( CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) && (textField.text?.count ?? 0 <= 1 )) {
                return true
            }
            
            else
            {
                return false
            }
            }
           else {
                return true
            }
            
           
        }
        return false
        
    }
    
    
    @IBAction func btn_continue_tap(_ sender: Any) {
       
        let params = ["user":AppHelper.getStringForKey(ServiceKeys.user_id),
                      "vehicle_number_one":self.txt_number1.text!,
                      "vehicle_number_two":self.txt_number2.text!,
                      "vehicle_number_three":self.txt_number3.text!,
                      "insurance_expire_date":self.txt_date.text!,
                      "color":self.selectedColor,
                      "model":self.txt_modelID]
        self.hudShow()
        if self.isFromCarEdit {
            self.updateCar(params: params)
        }
        else {
             self.saveCar(params: params)
        }
       
        
    }
    
    func updateCar(params:[String:String]) {
        ServiceClass.sharedInstance.hitServiceUpdateCar(params, id: (self.arr_cars?.vehicle_id!)!) { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
             if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.makeToast("success!")
                AppHelper.delay(1.0, closure: {
                    self.dismiss(animated: true, completion: {
                        
                    })
                })
            }
             else {
                self.makeToast(errorDict!["message"] as! String)
            }
        }
    }
    
    func saveCar(params:[String:String]) {
        ServiceClass.sharedInstance.hitServiceForGetCreateCar(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                if self.isFromEdit {
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: EditUserProfileVC.self) {
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
                }
                else {
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: DriverStep7VC.self) {
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
                }
                
                
            }
            else {
               self.makeToast(errorDict!["message"] as! String)
            }
            
        })
    }
}
