//
//  DriverStep8VC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 11/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep8VC: UIViewController {
    @IBOutlet weak var lblPassanger: UILabel!
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    
    @IBOutlet weak var btn_continue: UIButton!
    var ride:Ride!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.continueEnable()
        // Do any additional setup after loading the view.
    }
    @IBAction func actionBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func seat_btns(sender: AnyObject) {
        
        if sender.tag == 20 {
            
            let i : Int!
            
            //let s = self.lblPassanger.text
            let parts = self.lblPassanger.text?.components(separatedBy: " ")
            let  s = parts?[0]
          
            if let x = Int(s ?? "0") {
                //Archit..
                if (x < 6) {
                    i = x + 1
                    self.lblPassanger.text = i.description + " places"
                }
            }
            
        }
        else if sender.tag == 10 {
            let parts = self.lblPassanger.text?.components(separatedBy: " ")
            let  s = parts?[0]
            
            let i : Int!
            
            if let x = Int(s!) {
                if (x > 1) {
                    i = x - 1
                    self.lblPassanger.text = i.description + " places"
                }
            }
            
        }
    }
    
    @IBAction func btn_continue_tap(_ sender: Any) {
        let arr = self.lblPassanger.text!.split(separator: " ")
        self.ride.seats = String(arr[0])
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep9VC = storyboard.instantiateViewController(withIdentifier: "DriverStep9VC") as! DriverStep9VC
        vc.ride = self.ride
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func continueEnable() {
        btn_continue.isEnabled = true
        btn_continue.setTitle("Continuer👉", for: .normal)
        btn_continue.setTitleColor(UIColor.black, for: .normal)
    }
    
    func continueDisable() {
        btn_continue.isEnabled = false
        btn_continue.setTitle("Continuer👉🏼", for: .normal)
        btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
    }

}
