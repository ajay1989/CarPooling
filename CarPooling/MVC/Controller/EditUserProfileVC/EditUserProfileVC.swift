//
//  EditUserProfileVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 10/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class EditUserProfileVC: UIViewController {

    @IBOutlet weak var imgUser: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
imgUser.cornerRadius = 45 
        // Do any additional setup after loading the view.
    }
    @IBAction func goToBack(sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
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
