//
//  BookingConfirmedVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 21/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class BookingConfirmedVC: BaseViewController {
    var rideDetail: Ride!
    var arr_station: [Station]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   @IBAction func actionConfirm()
   {
    let params = ["from_city":self.rideDetail.from_city!,
                  "to_city":self.rideDetail.to_city!,
                  "ride":rideDetail.ride_id!,
                  "user":AppHelper.getStringForKey(ServiceKeys.user_id)]
    self.hudShow()
    
    ServiceClass.sharedInstance.hitServiceJoinRide(params as [String : Any], id:"") { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
        self.hudHide()
        if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
            self.makeToast("success!")
            AppHelper.delay(1.0, closure: {
                NotificationCenter.default.post(name: NSNotification.Name("fromBookingConfirm"), object: nil)
            })
        }
        else {
            self.makeToast("failed!")
        }
    }
    
    }

}
