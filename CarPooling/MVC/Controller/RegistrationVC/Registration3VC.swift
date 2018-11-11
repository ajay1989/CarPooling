//
//  Registration3VC.swift
//  CarPooling
//
//  Created by Ajay Vyas on 11/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class Registration3VC: BaseViewController {
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var vw_fname: UIView! {
        didSet {
            vw_fname.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    @IBOutlet weak var vw_lname: UIView! {
        didSet {
            vw_lname.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScrollView(scrollView)
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
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
        let vc: Registration4VC = storyboard.instantiateViewController(withIdentifier: "registration4VC") as! Registration4VC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
