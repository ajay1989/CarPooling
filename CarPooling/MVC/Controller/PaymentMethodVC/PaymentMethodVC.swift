//
//  PaymentMethodVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 14/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class PaymentMethodVC: UIViewController {
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_totalPrice: UILabel!
    var rideDetail: Ride!
    var arr_station: [Station]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_price.text = "\(rideDetail.price!) Dh"
        self.lbl_totalPrice.text = "\(rideDetail.price!) Dh"
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
    
    @IBAction func btn_pay(sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:BookingConfirmedVC = storyboard.instantiateViewController(withIdentifier: "BookingConfirmedVC") as! BookingConfirmedVC
        // self.present(vc, animated: true, completion: nil)
        vc.rideDetail = self.rideDetail
        vc.arr_station = self.arr_station
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
