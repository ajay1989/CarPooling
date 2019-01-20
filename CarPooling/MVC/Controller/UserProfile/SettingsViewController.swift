//
//  SettingsViewController.swift
//  CarPooling
//
//  Created by Ajay Vyas on 13/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

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
    
    @IBAction func btn_back_tap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_aide_tap(_ sender: Any) {
    }
    @IBAction func btn_noter_tap(_ sender: Any) {
    }
    
    @IBAction func btn_termsCondition_tap(_ sender: Any) {
    }
    
    @IBAction func btn_policies_tap(_ sender: Any) {
    }
    @IBAction func btn_logout_tap(_ sender: Any) {
        let otherAlert = UIAlertController(title: txt_AppName, message: "Are you sure you want to Logout?", preferredStyle: UIAlertController.Style.actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { _ in
            //if AppHelper.getStringForKey(ServiceKeys.account_type) == AccountType.Artist.rawValue{
            //    LocationClass.sharedInstance.stopLocationManager()
            //}
            Utilities.resetDefaults()
            let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let navigationController = UINavigationController(rootViewController: testController)
            appDelegate.window?.rootViewController = navigationController
            appDelegate.window?.makeKeyAndVisible()
//            self.callLogOutApi()
            
            
        }
        let NoAction = UIAlertAction(title: "No", style: UIAlertAction.Style.destructive) { _ in
        }
        
        // relate actions to controllers
        otherAlert.addAction(yesAction)
        otherAlert.addAction(NoAction)
        
        present(otherAlert, animated: true, completion: nil)
    }
    
    func callLogOutApi() {
        
        self.hudShow()
        var params = [String : Any]()
        
        params = ["user":AppHelper.getStringForKey(ServiceKeys.user_id)]
        ServiceClass.sharedInstance.hitserviceforLogOut(params: params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            
            print_debug("response: \(parseData)")
            
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                print(parseData)
                
                //                appDelegate.openDashBoard(isRemoveKey: true)
                Utilities.resetDefaults()
                let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                let navigationController = UINavigationController(rootViewController: testController)
                appDelegate.window?.rootViewController = navigationController
                appDelegate.window?.makeKeyAndVisible()
                
                
            }
            else {
                
                self.view.makeToast((errorDict?[ServiceKeys.keyErrorMessage] as? String)!, duration: 2.0, position: "CSToastPositionCenter")
                
            }
        })
    }
    
}
