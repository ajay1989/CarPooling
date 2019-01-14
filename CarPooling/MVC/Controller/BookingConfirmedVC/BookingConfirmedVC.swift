//
//  BookingConfirmedVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 14/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class BookingConfirmedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionDone()
    {
        
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "fromBookingConfirm"),
            object: self,
            userInfo: nil)
    }

}
