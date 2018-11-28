//
//  Registration1VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 11/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class Registration1VC: BaseViewController {
    
    @IBOutlet weak var lbl_detail1: UILabel!
    @IBOutlet weak var lbl_detail: UILabel!
    @IBOutlet weak var lbl_heading: UILabel!
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
    }
    
    @IBAction func btn_continue_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: Registration2VC = storyboard.instantiateViewController(withIdentifier: "registration2VC") as! Registration2VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_back_tap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
