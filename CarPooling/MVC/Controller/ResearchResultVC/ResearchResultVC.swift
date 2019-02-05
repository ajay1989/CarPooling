//
//  ResearchResultVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 21/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class ResearchResultVC: BaseViewController,UITextFieldDelegate {
   
    
    @IBOutlet weak var lbl_fromCity: UILabel!
    @IBOutlet weak var lbl_toCity: UILabel!
    
    
    @IBOutlet weak var view_Filter: UIView!
    @IBOutlet weak var ct_bottomVw: NSLayoutConstraint!
    @IBOutlet weak var tblVw: UITableView!
     @IBOutlet weak var btn_male: UIButton!
    @IBOutlet weak var btn_female: UIButton!
    
    @IBOutlet weak var txt_date: UITextField!
    
    let selectedColor = UIColor.init(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0)
    var arr_rides:Array = [Ride]()
    var gender = "0"
    var from_City:String = ""
    var to_city:String = ""
    var fromCityName = ""
    var toCityName = ""
    var departureDate:String = ""
    
    var customDatePicker:ActionSheetStringPicker = ActionSheetStringPicker.init()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         showDatePicker()
        view_Filter.isHidden = true
        tblVw.delegate = self
        tblVw.dataSource = self
        
        
        self.btn_female.isSelected = false
        self.btn_male.isSelected = true
        self.loadData()
        // Do any additional setup after loading the view.
        lbl_toCity.text = self.toCityName
        lbl_fromCity.text = self.fromCityName
    }
    
    
    //MARK: Action method
    @IBAction func alertCreate()
    {
       
        //Archit
            let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
            self.hudShow()
            ServiceClass.sharedInstance.hitServiceForGetCars(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
                self.hudHide()
                if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                    
//                    if (parseData["message"] != "No result found" ) {
//                        for data in parseData["data"]{
//                            let model = Car.init(fromJson: data.1)
//                            self.arr_cars.append(model)
//                        }
//                        if self.arr_cars.count>0 {
//                            self.tableView.reloadData()
//                        }
//                    }
                }
                else {
                    self.hudHide()
                    
                }
                
            })
            
        }
        
   
    @IBAction func btn_male_tap(_ sender: Any) {
        self.gender = "Male"
        self.btn_male.borderColor = selectedColor
        self.btn_female.borderColor = UIColor.darkGray
        self.btn_female.isSelected = false
        self.btn_male.isSelected = true
    }
    @IBAction func btn_female_tap(_ sender: Any) {
        self.gender = "Female"
        self.btn_male.borderColor = UIColor.darkGray
        self.btn_female.borderColor = selectedColor
        self.btn_female.isSelected = true
        self.btn_male.isSelected = false
    }
    @IBAction func hideFilterView()
    {
       hideView(view: view_Filter, hidden: true)
    }
    @IBAction func showFilterView()
    {
        setView(view: view_Filter, hidden: false)
    }
    @IBAction func actionGoToBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func setView(view: UIView, hidden: Bool) {

        view_Filter.isHidden = false
        UIView.animate(withDuration: 1, delay: 0.3, options: [.curveEaseIn],
                       animations: {
                       self.view_Filter.center.y -= self.view_Filter.bounds.height
                       self.ct_bottomVw.constant = 0
                        self.view_Filter.layoutIfNeeded()
        }, completion: nil)

   }
    func hideView(view: UIView, hidden: Bool) {
        
        
        UIView.animate(withDuration: 1, delay: 0.3, options: [.curveEaseIn],
                       animations: {
                        self.view_Filter.center.y += self.view_Filter.bounds.height
                        self.ct_bottomVw.constant = -self.view_Filter.bounds.height
                        self.view_Filter.layoutIfNeeded()
        }, completion: nil)
        
    }
    //MARK: PickerMethod
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txt_date.inputAccessoryView = toolbar
        txt_date.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        txt_date.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
      //  self.continueEnable()
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
        if (self.txt_date.text?.isEmpty)! {
           // self.continueDisable()
        }
        else {
          //  self.continueEnable()
        }
    }
    
    //MARK: Web method
    func loadData()
    {
        /*
       gender, departure_date, from_city, to_city, user
       */
        self.arr_rides.removeAll()
        //        self.tableView.reloadData()
        
        let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id), "gender":self.gender , "departure_date":self.txt_date.text ?? "" , "from_city":self.from_City , "to_city":self.to_city
        
            ] as [String : Any]
        
        
        
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetSearchRides(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            print_debug(parseData)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                
                if (parseData["message"] != "No result found" ) {
                    for data in parseData["data"]["ride"]{
                        let model = Ride.init(fromJson: data.1)
                        self.arr_rides.append(model)
                    }
                    if self.arr_rides.count>0 {
                        self.tblVw.reloadData()
                    }
                }
            }
            else {
                self.hudHide()
             self.makeToast(errorDict!["message"] as! String)
            }
            
        })
        
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
extension ResearchResultVC : UITableViewDataSource, UITableViewDelegate {
    
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
        let cell = tblVw.dequeueReusableCell(withIdentifier: "ReaserchResultTableViewCell", for: indexPath) as! ReaserchResultTableViewCell
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
        cell.lbl_fromDestination.text = data.from_city
        cell.lbl_ToDestination.text = data.to_city
        cell.lbl_timeFrom.text = data.departure_time
        cell.llbl_TimeTo.text = data.arrival_time
         let age = self.getAge(dob:data.dob!)
        cell.lbl_userName.text = data.first_name + "," + String(age) + "ans"
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
