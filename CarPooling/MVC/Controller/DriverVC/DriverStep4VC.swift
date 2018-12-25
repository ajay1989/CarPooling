//
//  DriverStep4VC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 11/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep4VC: UIViewController {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    var ride:Ride!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ride.from_city)
        print(ride.to_city)
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
    @IBAction func actionTest(sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep5VC = storyboard.instantiateViewController(withIdentifier: "DriverStep5VC") as! DriverStep5VC
        vc.ride = self.ride
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
