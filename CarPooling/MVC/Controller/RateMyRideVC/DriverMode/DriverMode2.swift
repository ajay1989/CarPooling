//
//  DriverMode2.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 18/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverMode2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction  func actionGoToBack()
    {
        // self.dismiss(animated: true, completion: nil)
       self.navigationController?.popViewController(animated: true)
    }

  @IBAction  func actionGoToDashboard()
    {
     // self.dismiss(animated: true, completion: nil)
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
  func postComment()
   {
    //passenger_attendance post with only comment
    //Post
    
    
    }
}
