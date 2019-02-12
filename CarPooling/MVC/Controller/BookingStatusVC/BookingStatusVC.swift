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
    //recherche
     @IBOutlet weak var btn_recherche: UIButton!
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
    
    @IBOutlet weak var lbl_address: UILabel!
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
    
    @IBOutlet weak var lbl_multiplecity: UILabel!
    var rideDetail: Ride!
     var arr_rides = [Ride]()
    var passenger: Passenger!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    } 
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadRideDetail()
        vw_contact.isHidden = true
        vw_contactShadow.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.black, radius: 0, opacity: 0.35)
    }
  
    // MARK: - ActionMethod
    
    @IBAction func hideContactView()
    {
        hideView(view: vw_contact, hidden: true)
    }
    @IBAction func showContactView()
    {
        setView(view: vw_contact, hidden: false)
    }
    @IBAction func actionGoToBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionGoToDashboard()
    {
       NotificationCenter.default.post(name: NSNotification.Name("fromBookingConfirm"), object: nil)
    }
    @IBAction func actionCancelRequest()
    {
        
        let otherAlert = UIAlertController(title: "", message: "Tu es sur le point d'annuler une demande validée.La place est automatiquement libérée pour les autres membres et il ne sera plus possible de faire marche arrière.", preferredStyle: UIAlertController.Style.actionSheet)
        
        let printSomething = UIAlertAction(title: "Confimer", style: UIAlertAction.Style.default) { _ in
            print("run code for cancel ride" )
            self.cancelRideRequest()
        }
        
       // let callFunction = UIAlertAction(title: "Call Function", style: UIAlertAction.Style.Destructive, handler: myHandler)
        
        let dismiss = UIAlertAction(title: "Retour", style: UIAlertAction.Style.cancel, handler: nil)
        
        // relate actions to controllers
        otherAlert.addAction(printSomething)
       // otherAlert.addAction(callFunction)
        otherAlert.addAction(dismiss)
        
        present(otherAlert, animated: true, completion: nil)
    }

    
    func setView(view: UIView, hidden: Bool) {
        
        vw_contact.isHidden = false
        UIView.animate(withDuration: 1, delay: 0.3, options: [.curveEaseIn],
                       animations: {
                        self.vw_contact.center.y -= self.vw_contact.bounds.height
                        self.ct_vwContactBottom.constant = 0
                        self.vw_contact.layoutIfNeeded()
        }, completion: nil)
        
    }
    func hideView(view: UIView, hidden: Bool) {
        
        
        UIView.animate(withDuration: 1, delay: 0.3, options: [.curveEaseIn],
                       animations: {
                        self.vw_contact.center.y += self.vw_contact.bounds.height
                        self.ct_vwContactBottom.constant = -self.vw_contact.bounds.height
                        self.vw_contact.layoutIfNeeded()
        }, completion: nil)
        
    }
    //MARK: set values
    func setValuesToView()
    {
        //Archit......
        let ride = self.arr_rides[0]
       // img_status: UIImageView!
     //   @IBOutlet weak var lbl_status: UILabel!
       
        
        
         lbl_dateFrom.text  = self.dateTimeFormateAccordingToUI(date: ride.departure_date, time: ride.departure_time) //"\(ride.departure_date!) \(ride.departure_time!)"
         lbl_dateTo.text = self.dateTimeFormateAccordingToUI(date: ride.arrival_date, time: ride.arrival_time) //"\(ride.arrival_date!) \(ride.arrival_time!)"
        let data = appDelegate.arr_city.filter({$0.city_id == ride.from_city!})
        let data1 = appDelegate.arr_city.filter({$0.city_id == ride.to_city!})
         lbl_fromCity.text = data[0].city_name
         lbl_toCity.text = data1[0].city_name
         lblSeats.text = "\(ride.available_seats!) place(s) restante(s)"
         lbl_price.text = "\(ride.price!)DH per passager"
         self.lbl_address.text = ride.from_city_address
        //status
      //  0-wating,1-approve,2-cancel,3-completed
        print(self.passenger.status)
        if self.passenger.status == "0" {
            self.lbl_status.text = "En attente de validation"
            self.img_status.image = UIImage.init(named: "yellow strip")
            //btn contact hide, btn demand show(cancel pending request api)
            self.btn_recherche.isHidden = true
            self.btn_contact.isHidden = true
            self.btn_demade.isHidden = false  // cancel
           
        }
        else if self.passenger.status == "1" {
            self.lbl_status.text = "Demande acceptée"
             self.img_status.image = UIImage.init(named: "green-strip")
            //show both button   "contacter le conducteur"   "Annuler ma demande"
            // demande = cancel pop up show
            self.btn_recherche.isHidden = true
            self.btn_contact.isHidden = false
            self.btn_demade.isHidden = false
        }
        else if self.passenger.status == "2" {
            self.lbl_status.text = "Demande refusée"
             self.img_status.image = UIImage.init(named: "red-strip")
            // single btn show with fray bordr text "Nouvelle recherche "
            // action go to dashboard applicable (btn text = Nouvelle recherche)
            self.btn_recherche.isHidden = false
            self.btn_contact.isHidden = true
            self.btn_demade.isHidden = true
        }
        else if self.passenger.status == "3" {
            self.lbl_status.text = "Completed"
             self.img_status.image = UIImage.init(named: "green-strip")
            self.btn_recherche.isHidden = false
            self.btn_contact.isHidden = true
            self.btn_demade.isHidden = true
        }
        else {
            self.lbl_status.text = "Completed"
             self.img_status.image = UIImage.init(named: "yellow strip")
            self.btn_recherche.isHidden = false
            self.btn_contact.isHidden = true
            self.btn_demade.isHidden = true
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
        if ride.duration != nil {
        let dateformatter2 = DateFormatter()
        dateformatter2.dateFormat = "HH:mm"
        let date2 = dateformatter2.date(from: ride.duration)
        dateformatter2.dateFormat = "hh'h'mm"
        let dateStr2:String = dateformatter2.string(from: date2!)
         lbl_distance.text = "Traget de " + ride.distance + "kms" + "\nen " + dateStr2
        
        }
        else
        {
            lbl_distance.text = "Traget de " + "0" + "kms" + "\nen " + "0"
        }
       // btn_demande.text = ""
    
        lbl_tripName.text = ride.brand_name + "," + ride.model_name
      //  let age = self.getAge(dob:ride.dob!)
      //  lbl_nameAge.text  = "\(ride.first_name!), \(age) ans"
        lbl_nameAge.text  = "\(ride.first_name!), \(ride.age!) ans"
       //  btn_contact.text = ""
        lbl_nameAge2.text  = "\(ride.first_name!), \(ride.age!) ans"
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(ride.profile_photo!)")!
         let placeholderImage = UIImage(named: "Male-driver")!
         img_user.af_setImage(withURL: url, placeholderImage: placeholderImage)
        img_user2.af_setImage(withURL: url, placeholderImage: placeholderImage)
        lbl_tripName.text = ride.brand_name + "," + ride.model_name
      if ride.station != nil
      {
        lbl_multiplecity.isHidden = false
      }
        else
      {
        lbl_multiplecity.isHidden = true
        }
        // btn_whatsap.text = ""
        // btmn_msg.text = ""
        // btn_phone.text = ""
     
        
    }
    //MARK: API method
    func loadRideDetail()
    {
        self.arr_rides.removeAll()
        let params = ["keyword":self.rideDetail.ride_id!]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetRideDetails(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let data = parseData["data"].dictionary!
                for ride in data["ride"]! {
                    self.arr_rides.append(Ride.init(fromJson: ride.1))
                }
                
                for passenge in data["passenger"]! {
                    var psng = Passenger.init(fromJson: passenge.1)
                    if (psng.user_id == AppHelper.getStringForKey(ServiceKeys.user_id) )
                    {
                        self.passenger = psng
                    }
                }
                // data["passenger"] -> match user id then status update
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
 func cancelRideRequest()
 {
    
    let params = ["keyword":self.passenger.ride_passenger_id!, "user":AppHelper.getStringForKey(ServiceKeys.user_id),
                  "status":"2", "note":"" , "ride" : self.rideDetail.ride_id]
    self.hudShow()
    ServiceClass.sharedInstance.hitServiceForChangeRideStatusPassenger(params as [String : Any], completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
        self.hudHide()
        if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
           // let data = parseData["data"].dictionary!
            
           // self.setValuesToView()
            self.makeToast("Success")
             self.navigationController?.popViewController(animated: true)
           
            
        }
        else {
            self.hudHide()
            
        }
        
    })
    }
}
