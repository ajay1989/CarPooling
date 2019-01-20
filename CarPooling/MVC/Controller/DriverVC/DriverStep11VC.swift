//
//  DriverStep11VC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 11/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep11VC: BaseViewController {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    var ride:Ride!
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
    @IBAction func btn_continue_tap(_ sender: Any) {
        let params = ["device_type":self.ride.device_type!,
                      "from_city":self.ride.from_city!,
                      "from_city_lat":self.ride.from_city_lat!,
                      "from_city_lng":self.ride.from_city_lng!,
                      "from_city_address":self.ride.from_city_address!,
                      "to_city":self.ride.to_city!,
                      "to_city_lat":self.ride.to_city_lat!,
                      "to_city_lng":self.ride.to_city_lng!,
                      "gender":self.ride.gender!,
                      "price":self.ride.price!,
                      "seats":self.ride.seats!,
                      "departure_date":self.ride.departure_date!,
                      "departure_time":self.ride.departure_time!,
                      "vehicle":self.ride.vehicle!,
                      "user":self.ride.user!,
                      "luggage":self.ride.luggage!]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetCreateRide(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.makeToast("Success")
                AppHelper.delay(2.0, closure: {
                    self.navigationController?.popToRootViewController(animated: true)
                })
                
            }
            else {
                self.makeToast("Failed")
            }
            
        })
    }
    
}
