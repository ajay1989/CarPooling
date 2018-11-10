//
//  ServiceClass.swift
//  TradeInYourLease
//
//  Created by Ajay Vyas on 10/2/17.
//  Copyright © 2017 Ajay Vyas. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ServiceClass: NSObject {

    static let sharedInstance = ServiceClass()
 
    enum ResponseType : Int {
        case   kResponseTypeFail = 0
        case  kresponseTypeSuccess
    }
    
    typealias completionBlockType = (ResponseType, JSON, AnyObject?) ->Void
    
    //MARK:- Common Get Webservice calling Method using SwiftyJSON and Alamofire
    func hitServiceWithUrlString( urlString:String, parameters:[String:AnyObject],headers:HTTPHeaders,completion:@escaping completionBlockType)
    {
        if Reachability.forInternetConnection()!.isReachable()
        {
            print(headers)
            
            Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers : headers)
                .responseJSON { response in
                    
                    guard case .success(let rawJSON) = response.result else {
                        print("SomeThing wrong")
                        
                        var errorDict:[String:Any] = [String:Any]()
                        errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                        errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                        
                        completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                        
                        return
                    }
                    if rawJSON is [String: Any] {
                        
                        let json = JSON(rawJSON)
                        print(json)
                        if  json["status"] == "error1"{
                            var errorDict:[String:Any] = [String:Any]()
                            
//                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
//                            errorDict[ServiceKeys.keyErrorMessage] = json["error"].stringValue
                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                            errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                            print(json["error_code"].stringValue)
                            
                            
                            if json["error_code"].stringValue == "delete_user"{
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                SVProgressHUD.dismiss()
                                appDelegate.logoutAlert(message: json["message"].stringValue)
                                
                            }
                            else {
                                completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                            }
                        }
                        else {
                            completion(ResponseType.kresponseTypeSuccess,json,nil)
                        }
                    }
            }
        }
        else {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let errorDict = NSMutableDictionary()
                errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                completion(ResponseType.kResponseTypeFail,nil,errorDict as NSDictionary)
            }
            
        }
        
    }
    func hitGetServiceWithUrlString( urlString:String, parameters:[String:Any],headers:HTTPHeaders,completion:@escaping completionBlockType)
    {
        if Reachability.forInternetConnection()!.isReachable()
        {
            let updatedUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            let url = URL(string: updatedUrl!)!
            
            Alamofire.request(url, method: .get , encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                
                guard case .success(let rawJSON) = response.result else {
                    print("SomeThing wrong")
                    
                    print(response.result)
                    
                    var errorDict:[String:Any] = [String:Any]()
                    errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                    errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                    
                    completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                    
                    return
                }
                if rawJSON is [Any] {
                    
                    let json = JSON(rawJSON)
                    
                    if  json["status"] == "error"{
                        var errorDict:[String:Any] = [String:Any]()
                        
                        errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                        errorDict[ServiceKeys.keyErrorMessage] = json["error"].stringValue
                        
                        completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                    }
                    else {
                        completion(ResponseType.kresponseTypeSuccess,json,nil)
                    }
                }
                if rawJSON is [String : Any] {
                    
                    let json = JSON(rawJSON)
                    
                    if  json["status"] == "error"{
                        var errorDict:[String:Any] = [String:Any]()
                        print(json)
                        
                        errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                        errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                        if json["error_code"].stringValue == "delete_user"{
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            SVProgressHUD.dismiss()
                            appDelegate.logoutAlert(message: json["message"].stringValue)
                            
                        }
                        else {
                            completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                        }
                        
                    }
                    else {
                        completion(ResponseType.kresponseTypeSuccess,json,nil)
                    }
                }
            }
        }
            
        else  {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let errorDict = NSMutableDictionary()
            errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
            errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
            completion(ResponseType.kResponseTypeFail,nil,errorDict as NSDictionary)
            
        }
        }
    }
    func imageUpload(_ urlString:String, params:[String : Any],data : Data,imageKey:String,headers:HTTPHeaders, completion:@escaping completionBlockType){
        
        print(urlString)
        print(params)
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(data , withName: imageKey, fileName: "imageKey.jpg", mimeType: "image/jpg")
            
            for (key, value) in params {
                // let str = "\(value)"
                //multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                if let val = value as? Bool{
                    var str = "Yes"
                    if val {
                        multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                    }
                    else {
                        str = "No"
                        multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                    }
                }
                else {
                    let str = "\(value)"
                    multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                }
            }
        },
                         usingThreshold:UInt64.init(), to:urlString,method:.post,headers:headers,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    
                                    guard case .success(let rawJSON) = response.result else {
                                        var errorDict:[String:Any] = [String:Any]()
                                        errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                        errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong" + urlString
                                        
                                        completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                                        
                                        return
                                    }
                                    print(rawJSON)
                                    if rawJSON is [String: Any] {
                                        
                                        let json = JSON(rawJSON)
                                        
                                        if json["status"] == "error"{
                                            var errorDict:[String:Any] = [String:Any]()
                                            
                                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                            errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                                            
                                            completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                                        }
                                        else {
                                            completion(ResponseType.kresponseTypeSuccess,json,nil)
                                        }
                                    }
                                    
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
    }
    
    
    // For SignUp
    func hitServiceForRegistration(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.enterregistrationcode)"
        print(baseUrl)
           let headers: HTTPHeaders = [ "Content-Type" : "application/json"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForCreateNewPassword(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.createpassword)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForForgotPassword(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.forgot_password)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForVerfication(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.verifyaccount)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForLogin(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.login)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForDashboard(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.dashboard_data)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForClinicList(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.clinics_list)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForClinicDetail(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.clinic_details)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForLogout(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.logout)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForProfile(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.profile)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForUpdateProfileImage(_ params:[String : Any],data : Data?, completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.update_profile_picture)"
        print(baseUrl)
        
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token"        : UserDefaults.standard.object(forKey: ServiceKeys.keyToken) as! String
        ]
        print_debug(params)
        print_debug(headers)
        self.imageUpload(baseUrl, params: params, data: data!, imageKey: "image", headers: headers, completion: completion)
    }
    
    func hitServiceForChangePassword(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.change_password)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token"        : UserDefaults.standard.object(forKey: ServiceKeys.keyToken) as! String
        ]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    
    func hitServiceForProfileUpdate(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.update_profile)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForDoctorList(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.all_doctors)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForBookAppointment(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.book_appoinmanet)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForAppointmentList(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.all_appoinmants)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForConfirmAppointment(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.confirm_appoinmants)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForCancelAppointment(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.cancel_appoinmants)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForFamilyMember(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.members_list)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForRescheduleAppointment(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.reshedule_appoinmants)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForNotificationList(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.notifications)"
        print(baseUrl)
        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
                                     "token":AppHelper.getStringForKey(ServiceKeys.keyToken)]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
   
//
//
//    func hitServiceForUpdateProfileImage(_ params:[String : Any],data : Data?, completion:@escaping completionBlockType)
//    {
//        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.update_profile_image)"
//        print(baseUrl)
//
//        let headers: HTTPHeaders = [ "Content-Type" : "application/json",
//                                     "token"        : UserDefaults.standard.object(forKey: ServiceKeys.keyToken) as! String
//        ]
//        print_debug(params)
//        print_debug(headers)
//        self.imageUpload(baseUrl, params: params, data: data!, imageKey: "profile_image", headers: headers, completion: completion)
//    }
//
//
//    func hitserviceforLogOut(params:[String : Any], completion:@escaping completionBlockType)
//    {
//        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.logout)"
//        let headers: HTTPHeaders = ["token": AppHelper.getStringForKey(ServiceKeys.keyToken)]
//        self.hitServiceWithUrlString(urlString: urlString, parameters: [ : ] , headers: headers, completion: completion)
//    }
//
   
    
 



}
