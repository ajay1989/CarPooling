//
//  UserProfileVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 09/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class UserProfileVC: BaseViewController {

    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_mobile: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_profile: UIImageView!
    var arr_comments = [Comment]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func goToBack(sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUser()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func loadUser() {
        let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetUserDetail(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            print_debug(parseData)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let basic = parseData["data"]["basic"].arrayValue
                let comments = parseData["data"]["comment"].arrayValue
                for data in basic {
                    let user = User.init(fromJson: data)
                    let url = URL(string: "\(ServiceUrls.profilePicURL)\(user.profile_photo!)")!
                    let placeholderImage = UIImage(named: "Male-driver")!
                    
                    self.img_profile.af_setImage(withURL: url, placeholderImage: placeholderImage)
                    self.lbl_name.text = "\(user.first_name!) \(user.last_name!)"
                    self.lbl_mobile.text = user.mobile_number
                    self.lbl_email.text = user.user_email
                    
                }
                for comment in comments {
                    let commentData = Comment.init(fromJson: comment)
                    self.arr_comments.append(commentData)
                }
                
                if self.arr_comments.count > 0 {
                    self.tableView.reloadData()
                }
                
            }
            else {
                self.hudHide()
                
            }
            
        })
    }
    
    @IBAction func btn_settings_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SettingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btn_alerts_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: AlertsViewController = storyboard.instantiateViewController(withIdentifier: "AlertsViewController") as! AlertsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension UserProfileVC : UITableViewDataSource, UITableViewDelegate {
    
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
        return self.arr_comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if placeArray.count > 0 {
        let data = self.arr_comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComentsTableViewCell", for: indexPath) as! ComentsTableViewCell
        //  cell.carColorPickerView.delegate = self
        cell.lblUserName.text = "\(data.first_name!) \(data.last_name!)"
        cell.lblDate.text = data.created_date!
        cell.txtDescription.text = data.comment!
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(data.profile_photo!)")!
        let placeholderImage = UIImage(named: "Male-driver")!
        
        cell.imgUser.af_setImage(withURL: url, placeholderImage: placeholderImage)
        cell.selectionStyle = .none
        return cell
        // }
        //p;return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc:BookingDetailVC = storyboard.instantiateViewController(withIdentifier: "BookingDetailVC") as! BookingDetailVC
        //        // self.present(vc, animated: true, completion: nil)
        //
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    // MARK: - ColorPickerViewDelegateFlowLayout
    
    
}
