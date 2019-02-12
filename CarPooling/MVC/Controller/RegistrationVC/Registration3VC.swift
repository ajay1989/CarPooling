//
//  Registration3VC.swift
//  CarPooling
//
//  Created by Ajay Vyas on 11/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class Registration3VC: BaseViewController,UITextFieldDelegate {
    // fb Est-ce qu'on a bien écrit ton Nom et Prénom ? (curious icon)
    // Merci de saisir ton Nom et Prénom pour que nous puissions t'accueillir comme il se doit (happy icon)
    @IBOutlet weak var lbl_textDetail: UILabel!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var btn_continue: UIButton!
    @IBOutlet weak var txt_firstName: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var vw_fname: UIView! {
        didSet {
            vw_fname.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    @IBOutlet weak var vw_lname: UIView! {
        didSet {
            vw_lname.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScrollView(scrollView)
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        if !AppHelper.getStringForKey(ServiceKeys.keyFirstName).isEqualToString(find: "") && !AppHelper.getStringForKey(ServiceKeys.keyLastName).isEqualToString(find: "") {
            self.txt_firstName.text = AppHelper.getStringForKey(ServiceKeys.keyFirstName)
            self.txt_lastName.text = AppHelper.getStringForKey(ServiceKeys.keyLastName)
            self.continueEnable()
            
           
        }
        else {
           
           
            continueDisable()
        }
        
        if !AppHelper.getStringForKey(ServiceKeys.keyFacebookID).isEqualToString(find: "") {
             lbl_textDetail.text = "Est-ce qu'on a bien écrit ton Nom et Prénom ? 🤔"
        }
        else
        {
           lbl_textDetail.text = "Merci de saisir ton Nom et Prénom pour que nous puissions t'accueillir comme il se doit 😊"
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
        AppHelper.setStringForKey(self.txt_firstName.text!, key: ServiceKeys.keyFirstName)
        AppHelper.setStringForKey(self.txt_lastName.text!, key: ServiceKeys.keyLastName)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: Registration4VC = storyboard.instantiateViewController(withIdentifier: "registration4VC") as! Registration4VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (self.txt_firstName.text?.count)!>2 && (self.txt_lastName.text?.count)!>1 {
                self.continueEnable()
            
        }
        else {
            self.continueDisable()
        }
        return true
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

}
