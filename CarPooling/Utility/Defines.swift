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
   
    static let keyErrorCode = "errorCode"
    static let keyErrorMessage = "errMessage"
    static let keyUserType = "user_type"
    
   
    static let keyEmail = "email"
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
    static let baseUrl = "http://xsdemo.com/clinic/api/"


//    static let baseUrl = "http://xsdemo.com/metrocontents/api/"

    static let enterregistrationcode = "patient/enter_registration_code"
    static let createpassword = "patient/create_password"
    static let forgot_password = "patient/forgot_password"
    static let verifyaccount = "patient/verify_account"
    static let login = "patient/login"
    static let dashboard_data = "patient/dashboard_data"
    static let clinics_list = "patient/clinics_list"
    static let clinic_details = "patient/clinic_details"
    static let logout = "patient/logout"
    static let profile = "patient/profile"
    static let update_profile_picture = "patient/update_profile_picture"
    static let change_password = "patient/change_password"
    static let update_profile = "patient/update_profile"
    static let all_doctors = "patient/all_doctors"
    static let book_appoinmanet = "patient/book_appoinmanet"
    static let all_appoinmants = "patient/all_appoinmants"
    static let confirm_appoinmants = "patient/confirm_appoinmants"
    static let cancel_appoinmants = "patient/cancel_appoinmants"
    static let members_list = "patient/members_list"
    static let reshedule_appoinmants = "patient/reshedule_appoinmants"
    static let notifications = "patient/notifications"
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






