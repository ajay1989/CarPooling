//
//  DriverStep3VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 01/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep3VC: UIViewController {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
          vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - CustomAction method
    @IBAction func actionNext(sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep4VC = storyboard.instantiateViewController(withIdentifier: "DriverStep4VC") as! DriverStep4VC
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }


}
