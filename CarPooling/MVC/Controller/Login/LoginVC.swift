//
//  LoginVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 11/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare
class LoginVC: BaseViewController {
    
    
    @IBOutlet weak var lbl_bottomText: UILabel!
    @IBOutlet weak var lbl_facebook: UILabel!
    @IBOutlet weak var lbl_centerText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
    override func viewWillAppear(_ animated: Bool) {
        self.hideNavigationController()
    }
    
    
    @IBAction func btn_continue_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: Registration1VC = storyboard.instantiateViewController(withIdentifier: "registration1VC") as! Registration1VC
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func btn_facebook_tap(_ sender: Any) {
        if let accessToken = AccessToken.current {
            self.getFBUserData()
        }
        else {
            let loginManager = LoginManager()
            loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) { (LoginResult) in
                switch LoginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login.")
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    self.getFBUserData()
                }
            }
            
    }
    }
    
    func getFBUserData() {
        let req = GraphRequest(graphPath: "me", parameters: ["fields": "email,first_name,last_name,gender,picture.type(large),id"], accessToken: AccessToken.current, httpMethod: GraphRequestHTTPMethod(rawValue: "GET")!)
        req.start({ (connection, result) in
            switch result {
            case .failed(let error):
                print(error)
                
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    print(responseDictionary)
                    let firstNameFB = responseDictionary["first_name"] as! String
                    let lastNameFB = responseDictionary["last_name"] as! String
                    let email = responseDictionary["email"] as! String
                    let socialIdFB = responseDictionary["id"] as! String
                    let idFB = responseDictionary["id"] as! String
                    let pictureUrlFB = responseDictionary["picture"] as! [String:Any]
                    let photoData = pictureUrlFB["data"] as! [String:Any]
                    let photoUrl = photoData["url"] as! String
                    print(firstNameFB, lastNameFB, socialIdFB, photoUrl)
                    
                    let params: [String : String] = ["fb_id":idFB]
                    self.hudShow()
                    ServiceClass.sharedInstance.hitServiceForLoginFB(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
                        self.hudHide()
                        if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                            let user = UserData.init(fromJson: parseData["data"])
                            AppHelper.setStringForKey(user.user_id!, key: ServiceKeys.user_id)
                            AppHelper.setStringForKey(user.profile_photo!, key: ServiceKeys.profile_image)
                            AppHelper.setStringForKey(user.user_fname!, key: ServiceKeys.keyFirstName)
                            appDelegate.loginUser()
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let vc: HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
                        else {
                            AppHelper.setStringForKey(firstNameFB, key: ServiceKeys.keyFirstName)
                            AppHelper.setStringForKey(lastNameFB, key: ServiceKeys.keyLastName)
                            AppHelper.setStringForKey(email, key: ServiceKeys.keyEmail)
                            AppHelper.setStringForKey(photoUrl, key: ServiceKeys.keyProfileImage)
                            AppHelper.setStringForKey(socialIdFB, key: ServiceKeys.keyFacebookID)
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc: Registration1VC = storyboard.instantiateViewController(withIdentifier: "registration1VC") as! Registration1VC
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    })

                    
                    
                }
            }
        })
    }
    
    
    @IBAction func btn_loginScreen_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: LoginEmailVC = storyboard.instantiateViewController(withIdentifier: "LoginEmailVC") as! LoginEmailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
