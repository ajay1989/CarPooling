//
//  DriverRequestDetailsVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 16/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverRequestDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToBack(sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
    }

}
