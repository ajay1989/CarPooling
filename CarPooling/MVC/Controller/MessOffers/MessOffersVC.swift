//
//  MessOffersVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 25/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class MessOffersVC: BaseViewController {
   
    
    
  
    @IBOutlet weak var btn_passengerList: UIButton!
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
    
    @IBOutlet weak var lbl_passengerCount: UILabel!
    
    @IBOutlet weak var collectionVw_multipleCity: UICollectionView!
    @IBOutlet weak var vw_multipleCity: UIView!
    
    var arr_rides = [Ride]()
     var rideDetail: Ride!
    var arr_passenger = [Passenger]()
    var arr_confirmedPassenger = [Passenger]()
    var arr_MultipleCity = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.loadRideDetails()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.loadRideDetails()
    }
    //MARK: Action method
    
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
        //Cancel  show alert
        let ride = self.arr_rides[0]
        let params = ["note":"Update ride from driver",
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
    @IBAction func hideContactView()
    {
        hideView(view: vw_contactPassenger, hidden: true)
    }
    @objc   func showContactView(_ sender: UIButton)
    {
        
        //set passngr data
        let data = self.arr_confirmedPassenger[sender.tag]
       // let age = self.getAge(dob:data.dob!)
      //  lbl_passegerName.text = data.first_name + ", " + String(age) + " ans"
         lbl_passegerName.text = data.first_name + ", " + data.age + " ans"
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(data.profile_photo!)")!
        let placeholderImage = UIImage(named: "Male-driver")!
        img_pasenger.af_setImage(withURL: url, placeholderImage: placeholderImage)
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
        vc.arr_passenger = self.arr_passenger
        vc.arr_confirmedPassenger = self.arr_confirmedPassenger
        vc.rideDetails = self.rideDetail
        // self.present(vc, animated: true, completion: nil)
        // vc.rideDetail = self.arr_rides[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        lbl_tripname.text = ride.brand_name + "," + ride.model_name
      
        self.arr_confirmedPassenger = self.arr_passenger.filter({$0.status == "1" })
        if self.arr_rides.count > 0 {
            self.btn_passengerList.isEnabled = true
            self.lbl_passengerCount.text = String(self.arr_passenger.count - self.arr_confirmedPassenger.count)
            
        }
        else
        {
            self.lbl_passengerCount.text = "0"
            self.btn_passengerList.isEnabled = false
        }
        if arr_MultipleCity.count == 0
        {
            self.vw_multipleCity.isHidden = true
        }
        else
        {
           collectionVw_multipleCity.delegate = self
            collectionVw_multipleCity.dataSource = self
        }
        self.tblVwPassenger.reloadData()
        
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
         self.arr_passenger.removeAll()
        self.arr_MultipleCity.removeAll()
        self.arr_confirmedPassenger.removeAll()
        let params = ["keyword":self.rideDetail.ride_id!]
        self.hudShow()
 ServiceClass.sharedInstance.hitServiceForGetRideDetails(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
           
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type)
            {
               // self.hudHide()
                let data = parseData["data"].dictionary!
                for ride in data["ride"]! {
                    self.arr_rides.append(Ride.init(fromJson: ride.1))
                }
               print(data["passenger"])
                if data["passenger"]?.stringValue == "" {
                for passenger in data["passenger"]! {
                    self.arr_passenger.append(Passenger.init(fromJson: passenger.1))
                }
                }
                //[\"21\",\"68\",\"68\"]", set multiple cities
                let ride = self.arr_rides[0]
                self.arr_MultipleCity = ride.station?.components(separatedBy: ",") ?? [""]
                let dict = ride.station?.toJSON() as? [String:AnyObject]
               print(dict)
                self.setValuesToView()
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
        if self.arr_rides.count > 0 && self.arr_confirmedPassenger.count > 0
        {
               let ride = self.arr_rides[0]
        if (arr_confirmedPassenger.count < Int(ride.seats)!)
        {
         return   self.arr_confirmedPassenger.count + 1
        }
        else if (self.arr_confirmedPassenger.count > 0)
           {
            return self.arr_confirmedPassenger.count
            }
        }
       
            return 0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if placeArray.count > 0 {
         let cell = tblVwPassenger.dequeueReusableCell(withIdentifier: "PassengerTableViewCell", for: indexPath) as! PassengerTableViewCell
        let ride = self.arr_rides[0]
        if arr_confirmedPassenger.count < Int(ride.seats)! && indexPath.row > arr_confirmedPassenger.count-1
         {
            
            let leftSeats = Int(self.rideDetail.seats)! - arr_confirmedPassenger.count
            
          //  let data = self.arr_confirmedPassenger[indexPath.row]
           // cell.btn_contact.tag = indexPath.row
          //  cell.btn_profile.tag = indexPath.row
            cell.btn_contact.isHidden = true
            
           cell.img_user.image = UIImage.init(named: "userBlack")
            cell.lbl_name.text = String(leftSeats) + " place(s) libre(s)"
        }
        else {
       
        let data = self.arr_confirmedPassenger[indexPath.row]
          //  let age = self.getAge(dob:data.dob!)
          //  cell.lbl_name.text = data.first_name + ", " + String(age) + " ans"
          cell.lbl_name.text = data.first_name + ", " + data.age + " ans"
        cell.btn_contact.tag = indexPath.row
        cell.btn_profile.tag = indexPath.row
        cell.btn_contact.addTarget(self, action: #selector(self.showContactView(_:)), for: .touchUpInside)
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(data.profile_photo!)")!
        let placeholderImage = UIImage(named: "Male-driver")!
        cell.img_user.af_setImage(withURL: url, placeholderImage: placeholderImage)
        cell.btn_profile.addTarget(self, action: #selector(self.actionProfileImage(_:)) , for: .touchUpInside)
        cell.btn_profile.tag = indexPath.row
        }
        return cell
       
    }
    @objc  func actionProfileImage(_ sender: UIButton)
    {
        let id = self.arr_rides[sender.tag].user_id
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:PublicProfileVC = storyboard.instantiateViewController(withIdentifier: "PublicProfileVC") as! PublicProfileVC
        // self.present(vc, animated: true, completion: nil)
        vc.id = id!
        self.navigationController?.pushViewController(vc, animated: true)
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
extension MessOffersVC :UICollectionViewDataSource,UICollectionViewDelegate{
//MARK: CollectionView delegate
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //
    return 4
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultipleCityCellCollectionViewCell", for: indexPath as IndexPath) as! MultipleCityCellCollectionViewCell
    
    // Use the outlet in our custom class to get a reference to the UILabel in the cell
    cell.lbl_name.text = "city name"
    
    return cell
}
//
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // handle tap events
    print("You selected cell #\(indexPath.item)!")
}
}
//
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
