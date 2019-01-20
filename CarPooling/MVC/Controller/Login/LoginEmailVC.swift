//
//  LoginEmailVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 13/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class LoginEmailVC: BaseViewController {
    
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var vw_email: UIView! {
        didSet {
            vw_email.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    @IBOutlet weak var vw_pass: UIView! {
        didSet {
            vw_pass.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func goToBack(sender: UIButton)
    {
        
        //self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btn_login_tap(_ sender: Any) {
        let params: [String : String] = ["email":self.txt_email.text!,
                                         "password":self.txt_password.text!,
                                         "imei_number":""]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForLogin(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
               let user = UserData.init(fromJson: parseData["data"])
                AppHelper.setStringForKey(user.user_id!, key: ServiceKeys.user_id)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else {
                self.makeToast(errorDict!["message"] as! String)
            }
            
        })
    }
}
