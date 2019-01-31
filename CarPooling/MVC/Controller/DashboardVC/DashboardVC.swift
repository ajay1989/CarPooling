//
//  DashboardVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 20/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DashboardVC: BaseViewController {
    
    @IBOutlet weak var tblVw: UITableView!
   
    
    @IBOutlet weak var img_profilePic: UIImageView!
   // @IBOutlet weak var searchBar: UISearchBar!
    var arr_rides:Array = [Ride]()
     var arr_city:Array = [City]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchBar.barTintColor = UIColor.clear
//        searchBar.backgroundColor = UIColor.clear
//        searchBar.isTranslucent = true
//        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)        // Do any additional setup after loading the view.
        tblVw.delegate = self
        tblVw.dataSource = self
        
        
        
        self.loadUserData()
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(AppHelper.getValueForKey(ServiceKeys.profile_image)!)")!

        let placeholderImage = UIImage(named: "Male-driver")!

        self.img_profilePic.af_setImage(withURL: url, placeholderImage: placeholderImage)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(AppHelper.getValueForKey(ServiceKeys.profile_image)!)")!
        
        let placeholderImage = UIImage(named: "Male-driver")!
        
        self.img_profilePic.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
    
    
    
    func loadUserData() {
        self.arr_rides.removeAll()
        //        self.tableView.reloadData()
        
        let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetRides(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            print_debug(parseData)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                
                if (parseData["message"] != "No result found" ) {
                    for data in parseData["data"]["ride"]{
                        let model = Ride.init(fromJson: data.1)
                        self.arr_rides.append(model)
                    }
                    if self.arr_rides.count>0 {
                        self.arr_city = appDelegate.arr_city
                        self.tblVw.reloadData()
                    }
                }
            }
            else {
                self.hudHide()
                
            }
            
        })
        
    }
    
    
    @IBAction func btn_profilePic_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:UserProfileVC = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
        // self.present(vc, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc  func actionProfileImage(_ sender: UIButton)
    {
        var id = self.arr_rides[sender.tag].user_id
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:PublicProfileVC = storyboard.instantiateViewController(withIdentifier: "PublicProfileVC") as! PublicProfileVC
        // self.present(vc, animated: true, completion: nil)
        vc.id = id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
    //MARK:- UIableView Data Source & Delegates Methods
    
    extension DashboardVC : UITableViewDataSource, UITableViewDelegate {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if self.arr_rides.count>0 {
                return self.arr_rides.count
            }
            else{
                return 0
                
            }
            //placeArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // if placeArray.count > 0 {
            let cell = tblVw.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell
             cell.vw_base.layer.cornerRadius = 15
            cell.vw_base.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
            cell.vw_green.clipsToBounds = true
            cell.vw_green.layer.cornerRadius = 15
            if #available(iOS 11.0, *) {
                cell.vw_green.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
           let data = self.arr_rides[indexPath.row]
            if (self.arr_city.count > 0 && data.from_city != "0" && data.to_city != "0"){
                 let dataCityfrom = self.arr_city[Int(data.from_city)! - 1 ]
                  let dataCityTo = self.arr_city[Int(data.to_city)! - 1]
                 cell.lbl_fromDestination.text = dataCityfrom.city_name!
                   cell.lbl_ToDestination.text = dataCityTo.city_name!
            }
            else
            {
                cell.lbl_fromDestination.text = data.from_city
                  cell.lbl_ToDestination.text = data.to_city
                
                
            }
        
            cell.lbl_timeFrom.text = data.departure_time
            cell.llbl_TimeTo.text = data.arrival_time
            cell.lbl_userName.text = data.first_name + data.last_name
             cell.lbl_seats.text = data.available_seats
            cell.lbl_Price.text = data.price
            
            let url = URL(string: "\(ServiceUrls.profilePicURL)\(data.profile_photo!)")!
            let placeholderImage = UIImage(named: "Male-driver")!
            
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
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc:BookingDetailVC = storyboard.instantiateViewController(withIdentifier: "BookingDetailVC") as! BookingDetailVC
    // self.present(vc, animated: true, completion: nil)
   vc.rideDetail = self.arr_rides[indexPath.row]
    self.navigationController?.pushViewController(vc, animated: true)
    
    
}
        
}
extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
//        layer.masksToBounds = false
//        layer.shadowOffset = offset
//        layer.shadowColor = color.cgColor
//        layer.shadowRadius = radius
//        layer.shadowOpacity = opacity
//
//        let backgroundCGColor = backgroundColor?.cgColor
//        backgroundColor = nil
//        layer.backgroundColor =  backgroundCGColor
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 6.0
        layer.masksToBounds = false
         backgroundColor = UIColor.white
    }
}
