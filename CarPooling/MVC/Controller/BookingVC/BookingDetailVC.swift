//
//  BookingDetailVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 29/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class BookingDetailVC: BaseViewController {
    
    @IBOutlet weak var lbl_From: UILabel!
    var ride_id = ""
    @IBOutlet weak var lbl_To: UILabel!
    @IBOutlet weak var lbl_DateFrom: UILabel!
    @IBOutlet weak var lbl_DateTo: UILabel!
    @IBOutlet weak var lbl_seat: UILabel!
    @IBOutlet weak var lbl_Lugguage: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    var arr_rides = [Ride]()
    //var arr_station = [Station]()
    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var lbl_tripName: UILabel!
    
    @IBOutlet weak var img_User: UIImageView!
    
    @IBOutlet weak var lbl_userNAmeAge: UILabel!
  @IBOutlet  var arrRank:[UIImageView]!
    
    var rideDetail: Ride!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadRide()
        // Do any additional setup after loading the view.
//        lbl_From.text = ""
//        
//        lbl_To.text = ""
//         lbl_DateFrom.text = ""
//        lbl_DateTo.text = ""
//         lbl_seat.text = ""
//        lbl_Lugguage.text = ""
//         lbl_Price.text = ""
//        
//      lbl_Distance.text = ""
//         lbl_tripName.text = ""
//        
//        img_User.image = UIImage.init(named: "")
        
       //  lbl_userNAmeAge: UILabel!
    }
    
    //MARK: Action method
    @IBAction func actionBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_payment_tap()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:PaymentMethodVC = storyboard.instantiateViewController(withIdentifier: "PaymentMethodVC") as! PaymentMethodVC
        // self.present(vc, animated: true, completion: nil)
        vc.rideDetail = self.arr_rides[0]
       // vc.arr_station = self.arr_station
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadRide() {
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
                
                if self.arr_rides.count > 0 {
                    let ride = self.arr_rides[0]
                    
                    let data = appDelegate.arr_city.filter({$0.city_id == ride.from_city!})
                    self.lbl_From.text = data[0].city_name
                    let data1 = appDelegate.arr_city.filter({$0.city_id == ride.to_city!})
                    self.lbl_To.text = data1[0].city_name
                    self.lbl_DateFrom.text =  self.dateTimeFormateAccordingToUI(date: ride.departure_date, time: ride.departure_time)
                    self.lbl_DateTo.text =  self.dateTimeFormateAccordingToUI(date: ride.arrival_date, time: ride.arrival_time)
                    self.lbl_seat.text = "\(ride.available_seats!) place(s) restante(s)"
                    self.lbl_Price.text = "\(ride.price!)DH per passager"
                    if ride.luggage == "" || ride.luggage == "1" {
                        self.lbl_Lugguage.text = "Petite valise"
                    }
                    else if ride.luggage == "2" {
                        self.lbl_Lugguage.text = "Moyenne"
                    }
                    else {
                        self.lbl_Lugguage.text = "Grande valise"
                    }
                    let age = self.getAge(dob:ride.dob!)
                    
                    self.lbl_userNAmeAge.text = ride.first_name + "," + String(age) + "ans"
                    let url = URL(string: "\(ServiceUrls.profilePicURL)\(ride.profile_photo!)")!
                    
                    let placeholderImage = UIImage(named: "Male-driver")!
                    
                    self.img_User.af_setImage(withURL: url, placeholderImage: placeholderImage)
                }
                
            }
            else {
                self.hudHide()
                
            }
            
        })
        
    }
}
