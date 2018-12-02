//
//  Registration4VC.swift
//  CarPooling
//
//  Created by Ajay Vyas on 11/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class Registration4VC: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var btn_continue: UIButton!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var vw_email: UIView! {
        didSet {
            vw_email.layer.borderColor =  UIColor(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
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
        if (txt_email.text?.isEmpty)! {
            btn_continue.isEnabled = false
            btn_continue.setTitle("Continue👉🏼", for: .normal)
            btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: Registration5VC = storyboard.instantiateViewController(withIdentifier: "Registration5VC") as! Registration5VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btn_back_tap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text?.count)! > 0 {
            if (textField.text?.isEmail)! {
                btn_continue.isEnabled = true
                btn_continue.setTitle("Continue👉", for: .normal)
                btn_continue.setTitleColor(UIColor.black, for: .normal)
            }
            else {
                btn_continue.isEnabled = false
                btn_continue.setTitle("Continue👉🏼", for: .normal)
                btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
            }
            
        }
        else {
            btn_continue.isEnabled = false
            btn_continue.setTitle("Continue👉🏼", for: .normal)
            btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
        }
        return true
    }
    
}
