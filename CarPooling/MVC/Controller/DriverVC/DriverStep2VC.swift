//
//  DriverStep2VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 01/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep2VC: UIViewController {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
           vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    var ride:Ride!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ride.from_city)
        print(ride.from_city_lat)
        // Do any additional setup after loading the view.
    }
    

    // MARK: - CustomAction method
    @IBAction func actionNext(sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep3VC = storyboard.instantiateViewController(withIdentifier: "DriverStep3VC") as! DriverStep3VC
        // self.present(vc, animated: true, completion: nil)
        vc.ride = self.ride
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

}
