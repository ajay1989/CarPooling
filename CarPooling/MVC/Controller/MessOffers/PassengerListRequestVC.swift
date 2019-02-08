//
//  PassengerListRequestVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 02/02/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class PassengerListRequestVC: BaseViewController {
 @IBOutlet weak var tblVwPassengerList: UITableView!
   @IBOutlet weak var btnConfirmed: UIButton!
    @IBOutlet weak var ct_vwTop: NSLayoutConstraint!
    @IBOutlet weak var vw_top: UIView!
    
    @IBOutlet weak var lbl_seatLeft: UILabel!
    @IBOutlet weak var tabVw_confirmed: UITableView!
    var rideDetails: Ride!
    var arr_passenger = [Passenger]()
    var arr_confirmedPassenger = [Passenger]()
    var arr_selectedPassenger = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        arr_passenger = self.arr_passenger.filter({$0.status == "0"  || $0.status == "2" })
        if arr_confirmedPassenger.count == 0
        {
           ct_vwTop.constant = 0
        }
        else
        {
            tabVw_confirmed.dataSource = self
            tabVw_confirmed.delegate = self
        }
        self.tblVwPassengerList.allowsMultipleSelection = true
        self.tblVwPassengerList.allowsMultipleSelectionDuringEditing = true
        
        self.tblVwPassengerList.delegate = self
        self.tblVwPassengerList.dataSource = self
        self.view.layoutSubviews()
        // Do any additional setup after loading the view.
    }
 override   func viewDidLayoutSubviews(){
        tabVw_confirmed.frame = CGRect(x: tabVw_confirmed.frame.origin.x, y: tabVw_confirmed.frame.origin.y, width: tabVw_confirmed.frame.size.width, height: tabVw_confirmed.contentSize.height)
        tabVw_confirmed.reloadData()
     self.btnConfirmed.isEnabled = false
    }
    @IBAction func actionGoBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc  func actionProfileImage(_ sender: UIButton)
    {
//        var id = self.arr_rides[sender.tag].user_id
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc:PublicProfileVC = storyboard.instantiateViewController(withIdentifier: "PublicProfileVC") as! PublicProfileVC
//        // self.present(vc, animated: true, completion: nil)
//        vc.id = id!
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func actionConfirmButton()
    {
        self.showSelectionPopUp()
        
    }
   func showSelectionPopUp()
   {
    let otherAlert = UIAlertController(title: "", message: "Souhaites-tu confirmer ta selection ? Nous enverrons une notification aux passagers selectionnés pour les prévenir.", preferredStyle: UIAlertController.Style.actionSheet)
    
    let printSomething = UIAlertAction(title: "Confimer", style: UIAlertAction.Style.default) { _ in
        print("run code for cancel ride" )
        self.confirmRideRequest()
    }
    
    // let callFunction = UIAlertAction(title: "Call Function", style: UIAlertAction.Style.Destructive, handler: myHandler)
    
    let dismiss = UIAlertAction(title: "Annuler", style: UIAlertAction.Style.cancel, handler: nil)
    
    // relate actions to controllers
    otherAlert.addAction(printSomething)
    // otherAlert.addAction(callFunction)
    otherAlert.addAction(dismiss)
    
    present(otherAlert, animated: true, completion: nil)
    
    }
    func confirmRideRequest()
    {
        //change_passenger_status  multiple ,POST      user, ride, status, note, passenger_id (, comma separated)
        // single , change_passenger_status/”ride passenger id”  - POST      user, ride, status, note 
        print(self.arr_selectedPassenger)
        var passengerIds = ""
        var  params = [String : Any]()
        if self.arr_selectedPassenger.count > 1
        {
            for str in self.arr_selectedPassenger
            {
              passengerIds =  passengerIds + "," + str
            }
            params = ["keyword":"", "user":AppHelper.getStringForKey(ServiceKeys.user_id),
                      "ride":self.rideDetails.ride_id, "status":"1", "note":"" , "passenger_id" : passengerIds]
        }
        else
        {
            var passeger = self.arr_selectedPassenger[0]
            params = ["keyword":self.arr_selectedPassenger[0], "user":AppHelper.getStringForKey(ServiceKeys.user_id),
                      "status":"1", "note":"" , "ride" : self.rideDetails.ride_id]
            
        }
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


//MARK: Passenger Tableview delegates
extension PassengerListRequestVC : UITableViewDataSource, UITableViewDelegate {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblVwPassengerList{
        if self.arr_passenger.count>0 {
                    return self.arr_passenger.count
            }
            else
           {
            return 0
            }
        }
        
             if tableView == tabVw_confirmed
             {
                if (self.arr_confirmedPassenger.count > 0)
                {
                return arr_confirmedPassenger.count
                }
                else
                {
                    return 0
                }
            }
             else {
                return 0
                     }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if placeArray.count > 0 {
        if tableView == tblVwPassengerList
        {
        let cell = tblVwPassengerList.dequeueReusableCell(withIdentifier: "PassengerListTableViiewCell", for: indexPath) as! PassengerListTableViiewCell
        let data = self.arr_passenger[indexPath.row]
        let age = self.getAge(dob:data.dob!)
        cell.lbl_userName.text = data.first_name + ", " + String(age) + " ans"
        // cell.btn_confirm.tag = indexPath.row
        // cell.btn_confirm.addTarget(self, action: #selector(self.confirmRequest(_:)), for: .touchUpInside)
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(data.profile_photo!)")!
        let placeholderImage = UIImage(named: "Male-driver")!
        cell.img_user.af_setImage(withURL: url, placeholderImage: placeholderImage)
        return cell
        }
        else
        {
            
            let cell = tabVw_confirmed.dequeueReusableCell(withIdentifier: "ConfirmedPAssengerTableViewcell", for: indexPath) as! ConfirmedPAssengerTableViewcell
            cell.btn_confirmed.isHidden = false
           let data = self.arr_passenger[indexPath.row]
            let age = self.getAge(dob:data.dob!)
            cell.lbl_name.text = data.first_name + ", " + String(age) + " ans"
            
            let url = URL(string: "\(ServiceUrls.profilePicURL)\(data.profile_photo!)")!
            let placeholderImage = UIImage(named: "Male-driver")!
            cell.img_userProfile.af_setImage(withURL: url, placeholderImage: placeholderImage)
            return cell
        }
        // }
        //p;return UITableViewCell()
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       
       
    if let cell = tableView.cellForRow(at: indexPath) {
    cell.accessoryType = .none
        let ids = self.arr_passenger[indexPath.row]
    arr_selectedPassenger =   arr_selectedPassenger.filter { $0 != ids.ride_passenger_id }
        
            }
        if arr_selectedPassenger.count == 0
        {
            self.btnConfirmed.borderColor = UIColor.gray
            self.btnConfirmed.isEnabled = false
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let data = self.arr_passenger[indexPath.row]
        if arr_selectedPassenger.count < Int(data.seats!)!
        {
            self.btnConfirmed.borderColor = UIColor.green
            self.btnConfirmed.titleLabel?.textColor = UIColor.green
            self.btnConfirmed.isEnabled = true
           if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
            let ids = self.arr_passenger[indexPath.row]
            arr_selectedPassenger.append(ids.ride_passenger_id)
            
            
            }
            
        }
        
    }
    
    
}
