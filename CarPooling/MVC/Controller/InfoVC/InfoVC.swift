//
//  InfoVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 29/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    @IBOutlet weak var btnMessanger: UIButton!{
        didSet{
            btnMessanger.layer.shadowColor = UIColor.gray.cgColor
            btnMessanger.layer.shadowOffset = CGSize(width: 0, height: 1)
            btnMessanger.layer.shadowOpacity = 0.7
            btnMessanger.layer.shadowRadius = 6.0
            btnMessanger.layer.masksToBounds = false
            btnMessanger.backgroundColor = UIColor.white
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
