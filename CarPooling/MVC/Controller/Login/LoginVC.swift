//
//  LoginVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 11/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    
    
    @IBOutlet weak var lbl_bottomText: UILabel!
    @IBOutlet weak var lbl_facebook: UILabel!
    @IBOutlet weak var lbl_centerText: UILabel!
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
    override func viewWillAppear(_ animated: Bool) {
        self.hideNavigationController()
    }
    
    
    @IBAction func btn_continue_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: Registration1VC = storyboard.instantiateViewController(withIdentifier: "registration1VC") as! Registration1VC
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
