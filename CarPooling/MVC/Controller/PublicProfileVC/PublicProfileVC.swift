//
//  PublicProfileVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 04/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class PublicProfileVC: BaseViewController {
    
    @IBOutlet weak var lbl_dob: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUser()
        // Do any additional setup after loading the view.
    }
    
    
    func loadUser() {
        let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetUserDetail(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            print_debug(parseData)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                
                for data in parseData["data"] {
                    let user = User.init(fromJson: data.1)
                    let url = URL(string: "https://i.stack.imgur.com/dWrvS.png")!
                    let placeholderImage = UIImage(named: "Male-driver")!
                    
                    self.img_profilePic.af_setImage(withURL: url, placeholderImage: placeholderImage)
                    self.lbl_name.text = "\(user.first_name!) \(user.last_name!)"
                    self.lbl_phone.text = user.mobile_number
                    self.lbl_email.text = user.user_email
                    
                    self.lbl_dob.text = user.dob
                }
                
                
            }
            else {
                self.hudHide()
                
            }
            
        })
    }
    
    
    @IBAction func btn_back_tap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
