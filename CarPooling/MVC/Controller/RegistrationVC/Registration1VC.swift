//
//  Registration1VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 11/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class Registration1VC: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var btn_continue: UIButton!
    @IBOutlet weak var lbl_detail1: UILabel!
    @IBOutlet weak var lbl_detail: UILabel!
    @IBOutlet weak var lbl_heading: UILabel!
    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var vw_number: UIView! {
        didSet {
            vw_number.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    override func viewWillAppear(_ animated: Bool) {
        self.hideNavigationController()
        if (self.txt_phone.text?.isEmpty)! {
            btn_continue.isEnabled = false
            btn_continue.setTitle("Continue👉🏼", for: .normal)
            btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
        }
        
    }
    
    
    
    @IBAction func btn_continue_tap(_ sender: Any) {

        let params: [String : String] = ["mobile_number":self.txt_phone.text!]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForCheckPhoneNumber(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){

                    print("sucess")
                AppHelper.setStringForKey(self.txt_phone.text!, key: ServiceKeys.keyContactPhoneNumber)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: Registration2VC = storyboard.instantiateViewController(withIdentifier: "registration2VC") as! Registration2VC
                self.navigationController?.pushViewController(vc, animated: true)

            }
            else {
                self.makeToast(errorDict!["errMessage"] as! String)
            }

        })
        
    }
    
    @IBAction func btn_back_tap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 9 {
            btn_continue.isEnabled = true
            btn_continue.setTitle("Continue👉", for: .normal)
            btn_continue.setTitleColor(UIColor.black, for: .normal)
        }
        else {
            btn_continue.isEnabled = false
            btn_continue.setTitle("Continue👉🏼", for: .normal)
            btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
        }
        return true
    }
    
}
