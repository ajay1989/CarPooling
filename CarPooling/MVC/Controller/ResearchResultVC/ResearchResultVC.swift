//
//  ResearchResultVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 21/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class ResearchResultVC: UIViewController {
 @IBOutlet weak var tblVw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionGoToBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

}
