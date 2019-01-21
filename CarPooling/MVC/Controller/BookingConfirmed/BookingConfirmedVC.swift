//
//  BookingConfirmedVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 21/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class BookingConfirmedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   @IBAction func actionConfirm()
   {
    //fromBookingConfirm
    NotificationCenter.default.post(name: NSNotification.Name("fromBookingConfirm"), object: nil)
    }

}
