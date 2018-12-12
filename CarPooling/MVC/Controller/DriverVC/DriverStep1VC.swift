//
//  DriverStep1VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 01/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep1VC: UIViewController {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
//            vw_Search.layer.shadowColor = UIColor.gray.cgColor
//            vw_Search.layer.shadowOffset = CGSize(width: 0, height: 1)
//            vw_Search.layer.shadowOpacity = 0.7
//            vw_Search.layer.shadowRadius = 6.0
//            vw_Search.layer.masksToBounds = false
//            vw_Search.backgroundColor = UIColor.white
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

