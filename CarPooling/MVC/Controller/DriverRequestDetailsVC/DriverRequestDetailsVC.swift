//
//  DriverRequestDetailsVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 16/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//
// means passenger Requests...............
import UIKit

class DriverRequestDetailsVC: BaseViewController {
    var isFromDashboard = false
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn_refused: UIButton!
    @IBOutlet weak var btn_completed: UIButton!
    @IBOutlet weak var btn_waitingApproval: UIButton!
    
    
    var arr_allRide = [Ride]()
    var arr_tempRide = [Ride]()
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_waitingApproval.borderColor = UIColor.init(red: (193.0/255.0), green: (164.0/255.0), blue: (85.0/255.0), alpha: 1)
        btn_waitingApproval.titleLabel?.textColor = UIColor.init(red: (193.0/255.0), green: (164.0/255.0), blue: (85.0/255.0), alpha: 1)
        btn_refused.borderColor = UIColor.lightGray
        btn_refused.titleLabel?.textColor = UIColor.lightGray
        btn_completed.borderColor = UIColor.lightGray
        btn_completed.titleLabel?.textColor = UIColor.lightGray
        if self.isFromDashboard {
            self.loadRidePassenger()  //passenger
            self.lbl_title.text = "Mes demandes"
        }
        else {
            self.loadRideDriver() //Driver
            self.lbl_title.text = "Mes offres"
        }
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToBack(sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_segment_tap(_ sender: Any) {
        self.arr_tempRide.removeAll()
        btn_waitingApproval.borderColor = UIColor.lightGray
        btn_waitingApproval.titleLabel?.textColor = UIColor.lightGray
        btn_refused.borderColor = UIColor.lightGray
        btn_refused.titleLabel?.textColor = UIColor.lightGray
        btn_completed.borderColor = UIColor.lightGray
        btn_completed.titleLabel?.textColor = UIColor.lightGray
        
        
        
        if (sender as AnyObject).tag == 1 {
            self.arr_tempRide = self.arr_allRide.filter({$0.status == "0" || $0.status == "1"})
            btn_waitingApproval.borderColor = UIColor.init(red: (193.0/255.0), green: (164.0/255.0), blue: (85.0/255.0), alpha: 1)
                        btn_waitingApproval.setTitleColor(UIColor.init(red: (193.0/255.0), green: (164.0/255.0), blue: (85.0/255.0), alpha: 1), for: .normal)
            
        }
        else if (sender as AnyObject).tag == 2 {
            self.arr_tempRide = self.arr_allRide.filter({$0.status == "2" || $0.status == "3"})
            btn_refused.borderColor = UIColor.init(red: (193.0/255.0), green: (164.0/255.0), blue: (85.0/255.0), alpha: 1)
            btn_refused.setTitleColor(UIColor.init(red: (193.0/255.0), green: (164.0/255.0), blue: (85.0/255.0), alpha: 1), for: .normal)
            
        }
        else {
            self.arr_tempRide = self.arr_allRide.filter({$0.status == "4"})
            btn_completed.borderColor = UIColor.init(red: (193.0/255.0), green: (164.0/255.0), blue: (85.0/255.0), alpha: 1)
            btn_completed.setTitleColor(UIColor.init(red: (193.0/255.0), green: (164.0/255.0), blue: (85.0/255.0), alpha: 1), for: .normal)
        }
        self.tableView.reloadData()
        
        
        
    }
    
    @objc  func actionProfileImage(_ sender: UIButton)
    {
        var id = self.arr_tempRide[sender.tag].user_id
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:PublicProfileVC = storyboard.instantiateViewController(withIdentifier: "PublicProfileVC") as! PublicProfileVC
        // self.present(vc, animated: true, completion: nil)
        vc.id = id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func loadRideDriver() {
        let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetDriverRide(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                if (parseData["message"] != "No result found" ) {
                    
                    for data in parseData["data"]["ride"]{
                        let model = Ride.init(fromJson: data.1)
                        self.arr_allRide.append(model)
                    }
                    self.arr_tempRide = self.arr_allRide.filter({$0.status == "0" || $0.status == "1"})
                    self.tableView.reloadData()
                }
                
            }
            else {
                self.hudHide()
                self.makeToast(errorDict!["message"] as! String)
            }
            
        })
        
    }
    
    
    func loadRidePassenger() {
        let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetPassengerRide(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                if (parseData["message"] != "No result found" ) {
                    
                    for data in parseData["data"]["ride"]{
                        let model = Ride.init(fromJson: data.1)
                        self.arr_allRide.append(model)
                    }
                   self.arr_tempRide = self.arr_allRide.filter({$0.status == "0" || $0.status == "1"})
                    self.tableView.reloadData()
                }
                
            }
            else {
                self.hudHide()
                self.makeToast(errorDict!["message"] as! String)
            }
            
        })
        
    }
    
}


extension DriverRequestDetailsVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arr_tempRide.count>0 {
            return self.arr_tempRide.count
        }
        else{
            return 0
            
        }
        //placeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if placeArray.count > 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell
        cell.vw_base.layer.cornerRadius = 15
        cell.vw_base.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
        cell.vw_green.clipsToBounds = true
        cell.vw_green.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            cell.vw_green.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        let data = self.arr_tempRide[indexPath.row]
        cell.lbl_fromDestination.text = data.from_city
        cell.lbl_ToDestination.text = data.to_city
        cell.lbl_timeFrom.text = data.departure_time
        cell.llbl_TimeTo.text = data.arrival_time
        cell.lbl_userName.text = data.first_name + data.last_name
        cell.lbl_seats.text = data.available_seats
        cell.lbl_Price.text = data.price
        
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(data.profile_photo!)")!
        let placeholderImage = UIImage(named: "placeholder")!
        
        cell.img_user.af_setImage(withURL: url, placeholderImage: placeholderImage)
        
        cell.btn_Profile.addTarget(self, action: #selector(self.actionProfileImage(_:)) , for: .touchUpInside)
        cell.btn_Profile.tag = indexPath.row
        return cell
        // }
        //p;return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFromDashboard
        {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:BookingStatusVC = storyboard.instantiateViewController(withIdentifier: "BookingStatusVC") as! BookingStatusVC
        // self.present(vc, animated: true, completion: nil)
        vc.rideDetail = self.arr_tempRide[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc:MessOffersVC = storyboard.instantiateViewController(withIdentifier: "MessOffersVC") as! MessOffersVC
            // self.present(vc, animated: true, completion: nil)
            vc.rideDetail = self.arr_tempRide[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
}
