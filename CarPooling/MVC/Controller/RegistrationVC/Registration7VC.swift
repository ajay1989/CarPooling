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
        imageData = image.pngData()!
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
                                         "password":"",
                                         "mobile_number":AppHelper.getStringForKey(ServiceKeys.keyContactPhoneNumber),
                                         "gender":AppHelper.getStringForKey(ServiceKeys.keyGender),
                                         "email":AppHelper.getStringForKey(ServiceKeys.keyEmail),
                                         "dob":AppHelper.getStringForKey(ServiceKeys.keyDOB),
                                         "profile_photo":self.imageData,
                                         "fb_id":AppHelper.getStringForKey(ServiceKeys.keyFacebookID)]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForRegistration(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                
                print("sucess")
                
                
            }
            else {
                self.makeToast(errorDict!["errMessage"] as! String)
            }
            
        })
    }
}
