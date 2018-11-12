
//
//  Registration5VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 12/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
//88 182 157
class Registration5VC: UIViewController {
    @IBOutlet weak var vw_number: UIView! {
        didSet {
            vw_number.layer.borderColor = UIColor(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
            vw_number.layer.borderWidth = 1.0
            vw_number.layer.cornerRadius = 20
            vw_number.layer.masksToBounds = true
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

}
