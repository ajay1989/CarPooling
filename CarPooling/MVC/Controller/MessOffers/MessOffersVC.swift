//
//  MessOffersVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 25/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class MessOffersVC: UIViewController {
     @IBOutlet weak var tblVwPassenger: UITableView!
  
    @IBOutlet weak var vw_contactPassenger: UIView!
       @IBOutlet weak var ct_vwContactBottom: NSLayoutConstraint!
    
    
    
    
    
    
      var arr_rides = [Ride]()
     var rideDetail: Ride!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: Action method
    // MARK: - ActionMethod
    @IBAction func hideContactView()
    {
        hideView(view: vw_contactPassenger, hidden: true)
    }
 @objc   func showContactView(_ sender: UIButton)
    {
        setView(view: vw_contactPassenger, hidden: false)
    }

   @IBAction func actionGoBack()
   {
    self.navigationController?.popViewController(animated: true)
    }
    //PassengerListRequestVC
    @IBAction func actionGoToPassengerList()
    {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc:PassengerListRequestVC = storyboard.instantiateViewController(withIdentifier: "PassengerListRequestVC") as! PassengerListRequestVC
                // self.present(vc, animated: true, completion: nil)
               // vc.rideDetail = self.arr_rides[indexPath.row]
          self.navigationController?.pushViewController(vc, animated: true)
    }
    func setView(view: UIView, hidden: Bool) {
        
        vw_contactPassenger.isHidden = false
        UIView.animate(withDuration: 1, delay: 0.3, options: [.curveEaseIn],
                       animations: {
                        self.vw_contactPassenger.center.y -= self.vw_contactPassenger.bounds.height
                        self.ct_vwContactBottom.constant = 0
                        self.vw_contactPassenger.layoutIfNeeded()
        }, completion: nil)
        
    }
    func hideView(view: UIView, hidden: Bool) {
        
        
        UIView.animate(withDuration: 1, delay: 0.3, options: [.curveEaseIn],
                       animations: {
                        self.vw_contactPassenger.center.y += self.vw_contactPassenger.bounds.height
                        self.ct_vwContactBottom.constant = -self.vw_contactPassenger.bounds.height
                        self.vw_contactPassenger.layoutIfNeeded()
        }, completion: nil)
        
    }
    //MARK: Web method
    func loadRideDetails()
    {
        let params = ["keyword":self.rideDetail.ride_id!]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetRideDetails(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let data = parseData["data"].dictionary!
                for ride in data["ride"]! {
                    self.arr_rides.append(Ride.init(fromJson: ride.1))
                }
                //                for station in data["station"]! {
                //                    self.arr_station.append(Station.init(fromJson: station.1))
                //                }
                self.setValuesToView()
                
                if self.arr_rides.count > 0 {
                    
                }
                
            }
            else {
                self.hudHide()
                
            }
            
        })
        
    }
    
}
 //MARK: Passenger Tableview delegates
extension MessOffersVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.arr_rides.count>0 {
//            return self.arr_rides.count
//        }
//        else{
//            return 0
//
//        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if placeArray.count > 0 {
        let cell = tblVwPassenger.dequeueReusableCell(withIdentifier: "PassengerTableViewCell", for: indexPath) as! PassengerTableViewCell
       cell.btn_contact.addTarget(self, action: #selector(self.showContactView(_:)), for: .touchUpInside)
        return cell
        // }
        //p;return UITableViewCell()
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 165
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc:BookingDetailVC = storyboard.instantiateViewController(withIdentifier: "BookingDetailVC") as! BookingDetailVC
//        // self.present(vc, animated: true, completion: nil)
//       // vc.rideDetail = self.arr_rides[indexPath.row]
      //  self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
