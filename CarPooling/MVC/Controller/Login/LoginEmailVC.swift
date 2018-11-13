//
//  LoginEmailVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 13/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class LoginEmailVC: UIViewController {
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
        
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
