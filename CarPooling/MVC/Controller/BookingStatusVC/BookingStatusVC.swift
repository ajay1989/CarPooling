//
//  BookingStatusVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 16/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//
/*
 0-wating,1-approve,2-cancel,3-start,4-
 */
import UIKit

class BookingStatusVC: BaseViewController {

    @IBOutlet weak var vw_contact: UIView!
    
    @IBOutlet weak var btn_Contact: UIButton!
    
    @IBOutlet weak var btn_demade: UIButton!
    
    @IBOutlet weak var ct_vwContactBottom: NSLayoutConstraint!
    
    @IBOutlet weak var vw_contactShadow: UIView!
   
    // outlets
    
    @IBOutlet weak var img_status: UIImageView!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_dateFrom: UILabel!
    @IBOutlet weak var lbl_dateTo: UILabel!
    @IBOutlet weak var lbl_fromCity: UILabel!
    @IBOutlet weak var lbl_toCity: UILabel!
    @IBOutlet weak var lblSeats: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_luggage: UILabel!
    @IBOutlet weak var lbl_distance: UILabel!
    
    @IBOutlet weak var btn_demande: UIButton!
    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var lbl_tripName: UILabel!
    @IBOutlet weak var lbl_nameAge: UILabel!
    @IBOutlet weak var btn_contact: UIButton!
    @IBOutlet weak var lbl_nameAge2: UILabel!
    @IBOutlet weak var img_user2: UIImageView!
    @IBOutlet weak var btn_whatsap: UIButton!
    @IBOutlet weak var btmn_msg: UIButton!
    @IBOutlet weak var btn_phone: UIButton!
    
    var rideDetail: Ride!
     var arr_rides = [Ride]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadRideDetail()
        vw_contact.isHidden = true
        vw_contactShadow.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.black, radius: 0, opacity: 0.35)
        // Do any additional setup after loading the view.
    } 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    //MARK: set values
    func setValuesToView()
    {
        let ride = self.arr_rides[0]
       // img_status: UIImageView!
     //   @IBOutlet weak var lbl_status: UILabel!
         lbl_dateFrom.text  = "\(ride.departure_date!) \(ride.departure_time!)"
         lbl_dateTo.text = "\(ride.arrival_date!) \(ride.arrival_time!)"
         lbl_fromCity.text = ride.from_city!
         lbl_toCity.text = ride.to_city!
         lblSeats.text = "\(ride.available_seats!) place(s) restante(s)"
         lbl_price.text = "\(ride.price!)DH per passager"
        //status
      //  0-wating,1-approve,2-cancel,3-completed
        if ride.status == "0" {
            self.lbl_luggage.text = "En attente de validation"
            self.img_status.image = UIImage.init(named: "yellow strip")
        }
        else if ride.status == "1" {
            self.lbl_luggage.text = "Demande acceptée"
             self.img_status.image = UIImage.init(named: "green-strip")
            //show both button   "contacter le conducteur"   "Annuler ma demande"
        }
        else if ride.status == "2" {
            self.lbl_luggage.text = "Demande refusée"
             self.img_status.image = UIImage.init(named: "red-strip")
            // single btn show with fray bordr text "Nouvelle recherche "
            
        }
        else if ride.status == "3" {
            self.lbl_luggage.text = "Completed"
             self.img_status.image = UIImage.init(named: "green-strip")
        }
        else {
            self.lbl_luggage.text = "Completed"
             self.img_status.image = UIImage.init(named: "yellow strip")
        }
        //
        if ride.luggage == "" || ride.luggage == "1" {
                                    self.lbl_luggage.text = "Petite valise"
                                }
                                else if ride.luggage == "2" {
                                    self.lbl_luggage.text = "Moyenne"
                                }
                                else {
                                    self.lbl_luggage.text = "Grande valise"
                                }
         lbl_distance.text = "0"
        
       // btn_demande.text = ""
    
        lbl_tripName.text = ""
        let age = self.getAge(dob:ride.dob!)
        lbl_nameAge.text  = "\(ride.first_name!) \(ride.last_name!), \(age) years"
       //  btn_contact.text = ""
        lbl_nameAge2.text  = "\(ride.first_name!) \(ride.last_name!), \(age) years"
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(ride.profile_photo!)")!
         let placeholderImage = UIImage(named: "Male-driver")!
         img_user.af_setImage(withURL: url, placeholderImage: placeholderImage)
        img_user2.af_setImage(withURL: url, placeholderImage: placeholderImage)
        // btn_whatsap.text = ""
        // btmn_msg.text = ""
        // btn_phone.text = ""
     
        
    }
    //MARK: API method
    func loadRideDetail()
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
