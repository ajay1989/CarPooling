//
//  MessOffersVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 25/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class MessOffersVC: BaseViewController {
    
  
    @IBOutlet weak var vw_contactPassenger: UIView!
       @IBOutlet weak var ct_vwContactBottom: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_fromcity: UILabel!
    @IBOutlet weak var lbl_fromDate: UILabel!
    @IBOutlet weak var lbl_toDate: UILabel!
    @IBOutlet weak var lbl_toCity: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_luggage: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_seats: UILabel!
    @IBOutlet weak var lbl_distace: UILabel!
    @IBOutlet weak var lbl_tripname: UILabel!
 @IBOutlet weak var tblVwPassenger: UITableView!
    // user profile info
    @IBOutlet weak var lbl_passegerName: UILabel!
    @IBOutlet weak var img_pasenger: UIImageView!
    
      var arr_rides = [Ride]()
     var rideDetail: Ride!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadRideDetails()
        // Do any additional setup after loading the view.
    }
    //MARK: view setup
    func setValuesToView()
    {
        let ride = self.arr_rides[0]
        // img_status: UIImageView!
        //   @IBOutlet weak var lbl_status: UILabel!
        
        lbl_fromDate.text  =  self.dateTimeFormateAccordingToUI(date: ride.departure_date, time: ride.departure_time)
        lbl_toDate.text =  self.dateTimeFormateAccordingToUI(date: ride.arrival_date, time: ride.arrival_time)
        let data = appDelegate.arr_city.filter({$0.city_id == ride.from_city!})
        let data1 = appDelegate.arr_city.filter({$0.city_id == ride.to_city!})
        lbl_fromcity.text = data[0].city_name
        lbl_toCity.text = data1[0].city_name
        lbl_address.text = ride.from_city_address
        lbl_seats.text = "\(ride.available_seats!) place(s) restante(s)"
        lbl_price.text = "\(ride.price!)DH per passager"
        //status
        //  0-wating,1-approve,2-cancel,3-completed
        if ride.status == "0" {
           
        }
        else if ride.status == "1" {
            
            //show both button   "contacter le conducteur"   "Annuler ma demande"
        }
        else if ride.status == "2" {
            
            // single btn show with fray bordr text "Nouvelle recherche "
            
        }
        else if ride.status == "3" {
           
        }
        else {
           
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
        lbl_distace.text = "Trajet de 300 kms\n en 3h30"
        
        // btn_demande.text = ""
        
        lbl_tripname.text = "yep yep yalah"
      
        
        
    }
    func setPassengerContact(passenger:User)
    {
        
       lbl_passegerName.text = passenger.first_name
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(passenger.profile_photo!)")!
        let placeholderImage = UIImage(named: "Male-driver")!
        img_pasenger.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
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
    
    @IBAction func btn_cancel_tap(_ sender: Any) {
        
        let otherAlert = UIAlertController(title: "", message: "Tu es sur le point d'annuler une demande validée.La place est automatiquement libérée pour les autres membres et il ne sera plus possible de faire marche arrière.", preferredStyle: UIAlertController.Style.actionSheet)
        
        let printSomething = UIAlertAction(title: "Confimer", style: UIAlertAction.Style.default) { _ in
            print("run code for cancel ride" )
            self.cancelRequest()
        }
        
        // let callFunction = UIAlertAction(title: "Call Function", style: UIAlertAction.Style.Destructive, handler: myHandler)
        
        let dismiss = UIAlertAction(title: "Retour", style: UIAlertAction.Style.cancel, handler: nil)
        
        // relate actions to controllers
        otherAlert.addAction(printSomething)
        // otherAlert.addAction(callFunction)
        otherAlert.addAction(dismiss)
        
        present(otherAlert, animated: true, completion: nil)
        
        
        
    }
    
    func cancelRequest() {
        let ride = self.arr_rides[0]
        let params = ["note":"Cancel ride from driver",
                      "ride":ride.ride_id!,
                      "status":"2",
                      "user":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        
        ServiceClass.sharedInstance.hitServiceUpdateRideFromDriver(params as [String : Any], id:ride.user_id) { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.makeToast("success!")
                self.navigationController?.popToRootViewController(animated: true)
            }
            else {
                self.makeToast("failed!")
            }
        }
    }
    
    
    @IBAction func btn_changeStatus_tap(_ sender: Any) {
        let ride = self.arr_rides[0]
        let params = ["note":"Update ride from driver",
                      "ride":ride.ride_id!,
                      "status":"1",
                      "user":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        
        ServiceClass.sharedInstance.hitServiceUpdateRideFromDriver(params as [String : Any], id:ride.user_id) { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.makeToast("success!")
                self.navigationController?.popToRootViewController(animated: true)
            }
            else {
                self.makeToast("failed!")
            }
        }
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
       // self.setPassengerContact() .............
        cell.btn_contact.addTarget(self, action: #selector(self.showContactView(_:)), for: .touchUpInside)
        
        
        return cell
       
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
