//
//  Registration1VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 11/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class Registration1VC: UIViewController {
    
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
    
}
