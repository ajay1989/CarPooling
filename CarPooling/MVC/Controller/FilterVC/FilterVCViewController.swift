//
//  FilterVCViewController.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 21/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class FilterVCViewController: UIViewController {
    
    @IBOutlet weak var vw_top:UIView!{
        didSet{
            vw_top.layer.shadowOffset = CGSize(width: 0, height: 3)
            vw_top.layer.shadowOpacity = 0.6
            vw_top.layer.shadowRadius = 3.0
            vw_top.layer.shadowColor = UIColor.lightGray.cgColor
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Custom Action
    
@IBAction func actionGoToBack()
{
    self.navigationController?.popViewController(animated: true)
    }
    
}
