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
                
                for data in parseData["data"] {
                    let user = User.init(fromJson: data.1)
                    let url = URL(string: "https://i.stack.imgur.com/dWrvS.png")!
                    let placeholderImage = UIImage(named: "Male-driver")!
                    
                    self.img_profile.af_setImage(withURL: url, placeholderImage: placeholderImage)
                    self.lbl_name.text = "\(user.first_name!) \(user.last_name!)"
                    self.lbl_mobile.text = user.mobile_number
                    self.lbl_email.text = user.user_email
                    
                }
                
                
            }
            else {
                self.hudHide()
                
            }
            
        })
    }
}
