//
//  Registration7VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 15/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class Registration7VC: BaseViewController {
    var image = UIImage()
    var imageData = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageData = image.jpeg(.low)!
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btn_register_tap(_ sender: Any) {
      
        
        let params: [String : Any] = ["first_name":AppHelper.getStringForKey(ServiceKeys.keyFirstName),
                                         "last_name":AppHelper.getStringForKey(ServiceKeys.keyLastName),
                                         "password":AppHelper.getStringForKey(ServiceKeys.KeyPassword),
                                         "mobile_number":AppHelper.getStringForKey(ServiceKeys.keyContactPhoneNumber),
                                         "gender":AppHelper.getStringForKey(ServiceKeys.keyGender),
                                         "email":AppHelper.getStringForKey(ServiceKeys.keyEmail),
                                         "dob":AppHelper.getStringForKey(ServiceKeys.keyDOB),
                                         
                                         "fb_id":AppHelper.getStringForKey(ServiceKeys.keyFacebookID),
                                         "device_type":"3",
                                         "imei_number":""]
        
        
      //  "profile_photo":self.imageData,
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForRegistration(params, self.imageData, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                
                self.makeToast("Success")
                AppHelper.delay(1.0, closure: {
                    if AppHelper.getStringForKey(ServiceKeys.keyFacebookID).isEqualToString(find: "") {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc: LoginEmailVC = storyboard.instantiateViewController(withIdentifier: "LoginEmailVC") as! LoginEmailVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else {
                       self.navigationController?.popToRootViewController(animated: true)
                    }
                    
                })
                
                
            }
            else {
                self.makeToast(errorDict!["message"] as! String)
            }
            
        })
    }
}
