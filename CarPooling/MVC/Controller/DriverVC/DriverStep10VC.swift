//
//  DriverStep10VC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 11/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep10VC: UIViewController {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    var int_selectedLuggage = 0
    @IBOutlet weak var btn_largeBaggage: UIButton!
    @IBOutlet weak var btn_mediumBaggae: UIButton!
    @IBOutlet weak var btn_smallBaggage: UIButton!
    var ride:Ride!
    var isSelected = "man"
    @IBOutlet weak var btn_both: UIButton!
    @IBOutlet weak var btn_man: UIButton!
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
    
    @IBAction func actionBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_man_tap(_ sender: Any) {
        self.btn_man.borderColor = UIColor.init(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0)
        self.isSelected = "1"
        self.btn_man.setImage(UIImage(named: "man-colored"), for: .normal)
        
        self.btn_both.borderColor = UIColor.darkGray
        self.btn_both.setImage(UIImage(named: "both"), for: .normal)
    }
    
    @IBAction func btn_baggage_tap(_ sender: Any) {
        self.btn_smallBaggage.isSelected = false
        self.btn_mediumBaggae.isSelected = false
        self.btn_largeBaggage.isSelected = false
        
        self.int_selectedLuggage = (sender as AnyObject).tag
        (sender as! UIButton).isSelected = true
        
    }
    
    @IBAction func btn_both_tap(_ sender: Any) {
        self.btn_man.borderColor = UIColor.darkGray
        self.isSelected = "0"
        self.btn_man.setImage(UIImage(named: "man"), for: .normal)
        
        self.btn_both.borderColor = UIColor.init(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0)
        self.btn_both.setImage(UIImage(named: "both-colored"), for: .normal)
    }
    
    
    @IBAction func btn_continue_tap(_ sender: Any) {
        self.ride.gender = self.isSelected
        self.ride.luggage = "\(self.int_selectedLuggage)"
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep11VC = storyboard.instantiateViewController(withIdentifier: "DriverStep11VC") as! DriverStep11VC
        vc.ride = self.ride
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
