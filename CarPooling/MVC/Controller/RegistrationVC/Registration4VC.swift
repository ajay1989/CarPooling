//
//  Registration4VC.swift
//  CarPooling
//
//  Created by Ajay Vyas on 11/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class Registration4VC: BaseViewController,UITextFieldDelegate {
    // Merci de nous indiquer le mail sur lequel tu souhaites recevoir toutes les informations pratiques concernant tes convoiturages 🚗
    // Merci de saisir le mail qui te servira d'identifiant pour ta prochaine connexion. Tu y recevras égalements toutes les informations pratiques concernant tes covoiturages (car icon)
    
    @IBOutlet weak var vw_password: UIView!
    
    @IBOutlet weak var lbl_mot: UILabel!
    
    @IBOutlet weak var lbl_textDetail: UILabel!
    
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var btn_continue: UIButton!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var img_email: UIImageView!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var vw_email: UIView! {
        didSet {
            vw_email.layer.borderColor =  UIColor(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // img_email.isHidden = true
        self.registerScrollView(scrollView)
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        if !AppHelper.getStringForKey(ServiceKeys.keyFirstName).isEqualToString(find: "") {
            self.txt_email.text = AppHelper.getStringForKey(ServiceKeys.keyEmail)
            btn_continue.isEnabled = true
            btn_continue.setTitle("Continuer👉", for: .normal)
            btn_continue.setTitleColor(UIColor.black, for: .normal)
            lbl_textDetail.text = "Merci de nous indiquer le mail sur lequel tu souhaites recevoir toutes les informations pratiques concernant tes convoiturages 🚗"
            self.vw_password.isHidden = true
            self.lbl_mot.isHidden = true
        }
        else {
            btn_continue.isEnabled = false
            btn_continue.setTitle("Continuer👉🏼", for: .normal)
            btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
            lbl_textDetail.text = "Merci de saisir le mail qui te servira d'identifiant pour ta prochaine connexion. Tu y recevras égalements toutes les informations pratiques concernant tes covoiturages 🚗"
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
    override func viewWillAppear(_ animated: Bool) {
        self.hideNavigationController()
    }
    
    @IBAction func btn_continue_tap(_ sender: Any) {
        let params: [String : String] = ["email":self.txt_email.text!]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForCheckEmail(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.img_email.image = UIImage.init(named: "checkcircle")
                print("sucess")
                AppHelper.setStringForKey(self.txt_email.text!, key: ServiceKeys.keyEmail)
                AppHelper.setStringForKey(self.txt_password.text!, key: ServiceKeys.KeyPassword)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: Registration5VC = storyboard.instantiateViewController(withIdentifier: "Registration5VC") as! Registration5VC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else {
                 self.img_email.image = UIImage.init(named: "cross")
                self.makeToast(errorDict!["message"] as! String)
            }
            
        })
        
    }
    @IBAction func btn_back_tap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var isEmailEnable = false
        var isPasswordEnable = false
        if (txt_email.text?.count)! > 0 {
            if (txt_email.text?.isEmail)! {
                self.img_email.image = UIImage.init(named: "checkcircle")
                isEmailEnable = true 
            }
            else {
                self.img_email.image = UIImage.init(named: "cross")
                isEmailEnable = false
            }
            
        }
        else {
            self.img_email.image = UIImage.init(named: "cross")
            isEmailEnable = false
            
        }
        if (txt_password.text?.count)! > 5 {
            isPasswordEnable = true
        }
        else {
            isPasswordEnable = false
        }
        
        if isEmailEnable && isPasswordEnable {
            btn_continue.isEnabled = true
            btn_continue.setTitle("Continuer👉", for: .normal)
            btn_continue.setTitleColor(UIColor.black, for: .normal)
        }
        else {
            btn_continue.isEnabled = false
            btn_continue.setTitle("Continuer👉🏼", for: .normal)
            btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
        }
        
        return true
    }
    
}
