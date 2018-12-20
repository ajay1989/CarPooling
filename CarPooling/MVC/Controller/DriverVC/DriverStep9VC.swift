//
//  DriverStep9VC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 11/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep9VC: UIViewController {
    @IBOutlet weak var lbl_Price:UILabel!
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func seat_btns(sender: AnyObject) {
        
        if sender.tag == 20 {
            
            let i : Int!
            
            //let s = self.lblPassanger.text
            let parts = self.lbl_Price.text?.components(separatedBy: " ")
            let  s = parts?[0]
            
            if let x = Int(s ?? "0") {
                if (x < 999999) {
                    i = x + 1
                    self.lbl_Price.text = i.description + " DH"
                }
            }
            
        }
        else if sender.tag == 10 {
            let parts = self.lbl_Price.text?.components(separatedBy: " ")
            let  s = parts?[0]
            
            let i : Int!
            
            if let x = Int(s!) {
                if (x > 1) {
                    i = x - 1
                    self.lbl_Price.text = i.description + " DH"
                }
            }
            
        }
    }


}
