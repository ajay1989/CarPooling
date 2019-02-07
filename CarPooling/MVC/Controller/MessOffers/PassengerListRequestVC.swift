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
   
    @IBOutlet weak var ct_vwTop: NSLayoutConstraint!
    @IBOutlet weak var vw_top: UIView!
    
    @IBOutlet weak var lbl_seatLeft: UILabel!
    @IBOutlet weak var tabVw_confirmed: UITableView!
    var arr_passenger = [Passenger]()
    var arr_confirmedPassenger = [Passenger]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view.
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
        //self.cancelRideRequest()
    }
    
    // let callFunction = UIAlertAction(title: "Call Function", style: UIAlertAction.Style.Destructive, handler: myHandler)
    
    let dismiss = UIAlertAction(title: "Annuler", style: UIAlertAction.Style.cancel, handler: nil)
    
    // relate actions to controllers
    otherAlert.addAction(printSomething)
    // otherAlert.addAction(callFunction)
    otherAlert.addAction(dismiss)
    
    present(otherAlert, animated: true, completion: nil)
    
    }

}
//MARK: Passenger Tableview delegates
extension PassengerListRequestVC : UITableViewDataSource, UITableViewDelegate {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                if self.arr_passenger.count>0 {
                    return self.arr_passenger.count
                }
                else{
                    return 0
        
                }
       
    }
     @objc  func confirmRequest(_ sender: UIButton)
     {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if placeArray.count > 0 {
        if tableView == tblVwPassengerList
        {
        let cell = tblVwPassengerList.dequeueReusableCell(withIdentifier: "PassengerListTableViiewCell", for: indexPath) as! PassengerListTableViiewCell
        let data = self.arr_passenger[indexPath.row]
        let age = self.getAge(dob:data.dob!)
        cell.lbl_userName.text = data.first_name + ", " + String(age) + " ans"
//         cell.btn_confirm.tag = indexPath.row
//        cell.btn_confirm.addTarget(self, action: #selector(self.confirmRequest(_:)), for: .touchUpInside)
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(data.profile_photo!)")!
        let placeholderImage = UIImage(named: "Male-driver")!
        cell.img_user.af_setImage(withURL: url, placeholderImage: placeholderImage)
        return cell
        }
        else
        {
            let cell = tblVwPassengerList.dequeueReusableCell(withIdentifier: "PassengerListTableViiewCell", for: indexPath) as! PassengerListTableViiewCell
            return cell
        }
        // }
        //p;return UITableViewCell()
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc:BookingDetailVC = storyboard.instantiateViewController(withIdentifier: "BookingDetailVC") as! BookingDetailVC
        //        // self.present(vc, animated: true, completion: nil)
        //       // vc.rideDetail = self.arr_rides[indexPath.row]
        //  self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
