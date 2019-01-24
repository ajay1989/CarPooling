//
//  Defines.swift
//  Panther
//
//  Created by Manish Jangid on 7/27/17.
//  Copyright © 2017 Manish Jangid. All rights reserved.
//

import Foundation
import UIKit




// MARK : GLOBAL Functions
func print_debug <T> (_ object:T)
{
    print(object)
}

let DateFormat_yyyy_mm_dd_hh_mm_ss_sss = "yyyy-MM-dd HH:mm:ss"

let DateFormat_yyyy_mm_dd_hh_mm_ss_0000 = "yyyy-MM-dd HH:mm:ss +0000"
let output_format_HH_mm_ss = "HH:mm:ss  MMM dd yyy"
let appDelegate = UIApplication.shared.delegate as! AppDelegate

struct GoogleMap {
    let key = "AIzaSyCQr-osxkKDbEvWGIh7sYgP2yApcWCe1Es"
    let geoCodingKey = "AIzaSyCQr-osxkKDbEvWGIh7sYgP2yApcWCe1Es"
}

let kCarMarkerImage = UIImage(named: "MarkerCar")
let kPolyLineStrokeColor = #colorLiteral(red: 0, green: 0.4392156863, blue: 0.9607843137, alpha: 0.7021885702)

//MARK:- Service Keys

struct ServiceKeys{
 
    
    static let user_id = "user_id"
    
    static let clock_in = "clock_in"
    static let clock_out = "clock_out"
    static let punchInTime = "punchInTime"
    static let ischeckForClick = "ischeckForClick"
    static let isCheckForClockOut = "isCheckForClockOut"
     static let userIntrectionCheck =  "userIntrectionCheck"
    
    static let dateFormat = "date_formate"
    static let timeFormat = "time_formate"
    static let keyToken = "token"
    static let KeyPassword = "KeyPassword"
    
    static let device_token = "device_token"
    static let keyUserName = "user_name"
    static let name = "name"
     static let key_employee_id = "employee_id"
         static let key_post = "post"
   
    static let profile_image = "profile_image"
    static let keyContactNumber = "contact_number"
    static let keyProfileImage = "image_url"
    static let keyFacebookID = "fbid"
   static let keyError = "error"
    static let keyErrorCode = "errorCode"
    static let keyErrorMessage = "message"
    static let keyUserType = "user_type"
    
   static let keyFirstName = "first_name"
    static let keyLastName = "last_name"
    static let keyEmail = "email"
    static let keyDOB = "dob"
    static let keyGender = "gender"
   static let KeyHealthID = "HealthID"
    static let keyContactEmail = "email"
    static let keyContactPhoneNumber = "phone_number"
      static let keyContactZip = "zip_code"
     static let keyContactDealer_id = "dealer_id"
    
  
    static let keyStatus =  "status"
    static let KeyAccountName = "account_name"
   
    static let address = "address"
   
    static let KeyPushNotificationDeviceToken = "KeyPushNotificationDeviceToken"
    static let KeyCarComparison = "KeyCarComparison"
    static let KeyCarFavourite = "KeyCarFavourite"
    static let KeyImageSlider = "KeyImageSlider"
}

struct ServiceUrls
{
    static let baseUrl = "http://echofounder.com/demo/carpoll/v1/api/"

    static let profilePicURL = "http://echofounder.com/demo/carpoll/assets/images/users/"
    static let profileDocURL = "http://echofounder.com/demo/carpoll/assets/images/user_docs/"

    static let checknumber = "checknumber"
    static let checkemail = "checkemail"
    static let register = "register"
    static let login = "login"
    static let user = "user"
    static let fblogin = "fblogin"
    static let search_model = "search_model"
    static let create_vehicle = "create_vehicle"
    static let user_vehicle = "user_vehicle"
    static let create_ride = "create_ride"
    static let ride = "ride"
    static let update_profile = "update_profile"
    static let logout = "logout"
    static let color = "color"
}
struct ErrorCodes
{
    static let    errorCodeInternetProblem = -1 //Unable to update use
    
    static let    errorCodeSuccess = 1 // 'Process successfully.'
    static let    errorCodeFailed = 2 // 'Process failed.
}


struct CustomColor{
    
    static let menuBGColor = UIColor(red: 29.0/255.0, green: 29.0/255.0, blue: 29.0/255.0, alpha: 1)
    static let button_color = UIColor(red: 67.0/255.0, green: 140.0/255.0, blue: 203.0/255.0, alpha: 1.0)
    
    //    static let menuselectedColor = UIColor(red: 66.0/255.0, green: 66.0/255.0, blue: 66.0/255.0, alpha: 0.8)
    static let redColor = UIColor(red: 132.0/255.0, green: 28.0/255.0, blue: 31.0/255.0, alpha: 1.0)
    static let menuselectedColor = UIColor.lightGray
    static let blackThemeColor = UIColor(red: 58.0/255.0, green: 58.0/255.0, blue: 58.0/255.0, alpha: 1.0)
    static let borderThemeColor = UIColor(red: 58.0/255.0, green: 58.0/255.0, blue: 58.0/255.0, alpha: 0.5)
    static let blackBgColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
    static let appThemeColor = UIColor(red: 244/255.0, green: 86.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    static let appThemeColorAlpha = UIColor(red: 244/255.0, green: 86.0/255.0, blue: 30.0/255.0, alpha: 0.2)
    static let darkTextColorTheme = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    static let backgroundColorTheme = UIColor(red: 96.0/255.0, green: 126.0/255.0, blue: 140.0/255.0, alpha: 1.0)
    static let pageTitleColor = UIColor(red: 26/255.0, green: 26.0/255.0, blue: 26.0/255.0, alpha: 0.8)
    static let text_Color_White = UIColor.white
       static let nav_color = UIColor.white

    
}


struct CustomFont {
    static let boldfont13 = UIFont(name: "Montserrat-Bold", size: 13)!
    static let boldfont18 =  UIFont(name: "Montserrat-Bold", size: 18)!
    
}






