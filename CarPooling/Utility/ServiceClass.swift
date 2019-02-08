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
    typealias completionBlockTypeData = (ResponseType, [String:Any], AnyObject?) ->Void
    //MARK:- Common Get Webservice calling Method using SwiftyJSON and Alamofire
    func hitServiceWithUrlString( urlString:String, parameters:[String:AnyObject],headers:HTTPHeaders,completion:@escaping completionBlockType)
    {
        if Reachability.forInternetConnection()!.isReachable()
        {
            print(headers)
            
            Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers : headers)
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
                        if  json["status"] == false{
                            var errorDict:[String:Any] = [String:Any]()
                            
//                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
//                            errorDict[ServiceKeys.keyErrorMessage] = json["error"].stringValue
                            
                            errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                           
                                completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                            
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
    func hitGetServiceWithUrlStringGetData( urlString:String, parameters:[String:Any],headers:HTTPHeaders,completion:@escaping completionBlockTypeData)
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
                    
                   // completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                    
                    return
                }
                if rawJSON is [Any] {
                    
                    let json = JSON(rawJSON)
                    
                    if  json["status"] == "error"{
                        var errorDict:[String:Any] = [String:Any]()
                        
                        errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                        errorDict[ServiceKeys.keyErrorMessage] = json["error"].stringValue
                        
                      //  completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                    }
                    else {
                        completion(ResponseType.kresponseTypeSuccess,rawJSON as! [String : Any] ,nil)
                    }
                }
                if rawJSON is [String : Any] {
                    
                    let json = JSON(rawJSON)
                    
                    if  json["status"].bool == false{
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
                          //  completion(ResponseType.kResponseTypeFail,nil,errorDict as AnyObject);
                        }
                        
                    }
                    else {
                        completion(ResponseType.kresponseTypeSuccess,rawJSON as! [String : Any] ,nil)
                    }
                }
            }
        }
            
        else  {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                let errorDict = NSMutableDictionary()
                errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                //completion(ResponseType.kResponseTypeFail,nil,errorDict as NSDictionary)
                
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
                    
                    if  json["status"].bool == false{
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
    func hitServiceForCheckPhoneNumber(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.checknumber)"
        print(baseUrl)
           let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForCheckEmail(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.checkemail)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForRegistration(_ params:[String:Any],_ img: Data, completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrlr = "\(ServiceUrls.baseUrl)\(ServiceUrls.register)"
        print(baseUrlr)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrlr, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        
//        Alamofire.upload(multipartFormData: { multipartFormData in
//
//            for (key, value) in params {
//                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
//            }
//
//            multipartFormData.append(img, withName: "profile_photo", fileName: "profile_photo", mimeType: "image/jpeg")
//        }, to: baseUrlr, encodingCompletion: { result in
//            print("result  = \(result)")
//            switch result {
//            case .success(request: let request, streamingFromDisk: false, streamFileURL: nil):
//                //Success code
//                print("result  = \(request)")
//               completion(ResponseType.kresponseTypeSuccess,nil,result as AnyObject);
//
//
//
//
//                break
//
//            case .failure:
//                print("failed api calling")
//                break
//
//
//            case .success(let request, true, _):
//                //Code here
//                break
//
//            case .success(let request, _, _):
//                // Code here
//                break
//            }
//        })
    }

        
        
        
        
        
        
//        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    
  func hitServiceForChangeRideStatusPassenger(_ params:[String : Any], completion:@escaping completionBlockType)
  {
    //change_passenger_status
    let user = "admin"
    let password = "1234"
    let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
    let base64Credentials = credentialData.base64EncodedString(options: [])
    let str:String = (params["keyword"]! as! String)
    var   baseUrl = ""
    if str.count > 0 {
     baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.change_ride_statusPassenger)/\(str)"
    }
    else
    {
        baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.change_ride_statusPassenger)"
    }
    print(baseUrl)
    let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
        "X-API-KEY":"CYLPIUnVia7UUl"]
    print_debug(params)
    self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    
    }
    
    func hitServiceForPostRegistrationImage(_ params:[String : Any],data : Data?, completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.register)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.imageUpload(baseUrl, params: params, data: data!, imageKey: "profile_photo", headers: headers, completion: completion)
    }
    
    func hitServiceForLogin(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.login)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
   
    func hitServiceForProfile(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.user)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitserviceforLogOut(params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.logout)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForLoginFB(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.fblogin)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForGetModel(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.search_model)/\(params["keyword"]!)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
//        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: ["":""], headers: headers, completion: completion)
    }
    
    func hitServiceForGetCars(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.user_vehicle)/\(params["keyword"]!)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: ["":""], headers: headers, completion: completion)
    }
  
    func hitServiceForGetPriceAndDistance(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        //Ajay tere kale karname
       // let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.city_distance)"
       //let baseUrl1 = "http://echofounder.com/demo/carpoll/v1/api/city_distance?from_city=21&to_city=13&seats=2"
        
        let toCity:String = params["to_city"] as! String
        let fromCity:String = params["from_city"] as! String
        let seats:String = params["seats"] as! String
        let baseUrl = "http://echofounder.com/demo/carpoll/v1/api/city_distance" + "?from_city=" + fromCity + "&to_city=" + toCity + "&seats=" + seats
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: params, headers: headers, completion: completion)
    }
    func hitServiceForGetRideDetails(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.ride)/\(params["keyword"]!)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: ["":""], headers: headers, completion: completion)
    }
    
    func hitServiceForGetPassengerRide(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.passenger_rides)/\(params["keyword"]!)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: ["":""], headers: headers, completion: completion)
    }
    
    func hitServiceForGetDriverRide(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.driver_rides)/\(params["keyword"]!)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: ["":""], headers: headers, completion: completion)
    }
    
    func hitServiceForGetColor(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.color)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: ["":""], headers: headers, completion: completion)
    }
    
    
    func hitServiceForGetCity(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.city)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: ["":""], headers: headers, completion: completion)
    }
    func hitServiceForGetRides(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.ride)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(headers)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: ["":""], headers: headers, completion: completion)
    }
    
    func hitServiceForGetSearchRides(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.search_Ride)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(headers)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
  self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject], headers: headers, completion: completion)
       
    }
    
    func hitServiceForGetUserDetail(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.user)/\(params["keyword"] as! String)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(headers)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitGetServiceWithUrlString(urlString: baseUrl, parameters: ["":""], headers: headers, completion: completion)
    }
    
    func hitServiceForUpdateUserDetail(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.update_profile)/\(AppHelper.getStringForKey(ServiceKeys.user_id))"
        print(baseUrl)
        print(params)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(headers)
        //        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    
    func hitServiceForUpdateProfileImage(_ params:[String : Any],data : Data?, completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.update_profile)/\(AppHelper.getStringForKey(ServiceKeys.user_id))"
        print(baseUrl)
        print(params)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(headers)
        self.imageUpload(baseUrl, params: params, data: data!, imageKey: "profile_photo", headers: headers, completion: completion)
    }
    
    func hitServiceForGetCreateCar(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.create_vehicle)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceUpdateCar(_ params:[String : Any],id:String, completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.create_vehicle)/\(id)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceJoinRide(_ params:[String : Any],id:String, completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.create_passenger)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceConfirmPassengerRequest(_ params:[String : Any],id:String, completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.change_passenger_status)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceUpdateRideFromDriver(_ params:[String : Any],id:String, completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.change_passenger_status)/\(id)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForGetCreateRide(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let user = "admin"
        let password = "1234"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.create_ride)"
        print(baseUrl)
        let headers: HTTPHeaders = ["Authorization": "Basic \(base64Credentials)",
            "X-API-KEY":"CYLPIUnVia7UUl"]
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
