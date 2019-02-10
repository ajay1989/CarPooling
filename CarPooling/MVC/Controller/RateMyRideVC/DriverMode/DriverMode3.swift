//
//  DriverMode3.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 18/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverMode3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   func loadPassengerDetail()
   {
    let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
   // self.hudShow()
    ServiceClass.sharedInstance.hitServiceForGetFinalPassenger(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
       // self.hudHide()
        print_debug(parseData)
        if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
            let basic = parseData["data"]["basic"].arrayValue
            let comments = parseData["data"]["comment"].arrayValue
//            for data in basic {
//                let user = User.init(fromJson: data)
//                let url = URL(string: "\(ServiceUrls.profilePicURL)\(user.profile_photo!)")!
//                let placeholderImage = UIImage(named: "Male-driver")!
//
//                self.imgUser.af_setImage(withURL: url, placeholderImage: placeholderImage)
//
//            }
//            for comment in comments {
//                let commentData = Comment.init(fromJson: comment)
//                self.arr_comments.append(commentData)
//            }
            
        }
        else {
            //self.hudHide()
            
        }
        
    })
    }

}
