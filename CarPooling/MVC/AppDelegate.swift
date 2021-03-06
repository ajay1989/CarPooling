//
//  AppDelegate.swift
//  CarPooling
//
//  Created by Ajay Vyas on 10/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//
// Ajay Commit git
import UIKit
import CoreData
import FacebookCore
import FacebookLogin
import FacebookShare
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces
@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var arr_color = [Color]()
    var arr_city = [City]()
    var nav = UINavigationController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.loadCity()
        self.loadColor()
      
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(GoogleMap().key)
        GMSPlacesClient.provideAPIKey(GoogleMap().key)
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
       
        if !AppHelper.getStringForKey(ServiceKeys.user_id).isEqualToString(find: "") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            nav = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
        else
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            nav = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
       
        print_debug("app first launch")
        return true
    }
    
    
   
    
    func loadColor() {
        let params = ["":""]
        ServiceClass.sharedInstance.hitServiceForGetColor(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                
                if (parseData["message"] != "No result found" ) {
                    for data in parseData["data"]{
                        let color = Color.init(fromJson: data.1)
                        self.arr_color.append(color)
                    }
                }
            }
            else {
                
            }
            
        })
        
    }
    
    func loadCity() {
        let params = ["":""]
        ServiceClass.sharedInstance.hitServiceForGetCity(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                
                if (parseData["message"] != "No result found" ) {
                    for data in parseData["data"]{
                        let city = City.init(fromJson: data.1)
                        self.arr_city.append(city)
                    }
                    if self.arr_city.count > 0 {
                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
                    }
                }
            }
            else {
                
            }
            
        })
        
        
        
    }
    func loginUser()
    {
        
//   if !AppHelper.getStringForKey(ServiceKeys.user_id).isEqualToString(find: "")
//        {
    
            
//    if (!self.nav.topViewController.is(HomeVC.class
//            )) {
    
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                vc.selectedIndex = 0
                self.nav.setViewControllers([vc], animated: true)
              
                
            //}
       // }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
      //  self.checkUserReviewStatus()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppEventsLogger.activate(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let appId: String = SDKSettings.appId
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
            return SDKApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return false
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CarPooling")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    @available(iOS 10.0, *)
    func saveContext () {
//        if #available(iOS 10.0, *) {
//            let context = persistentContainer.viewContext
//        } else {
//            // Fallback on earlier versions
//        }
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
    }
    func logout()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
       self.nav.setViewControllers([vc], animated: true)
    }
    func logoutAlert(message:String) {
        let alertController = UIAlertController(title: txt_AppName, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            Utilities.resetDefaults()
            
//            let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
//            let navigationController = UINavigationController(rootViewController: testController)
//            self.window?.rootViewController = navigationController
//            self.window?.makeKeyAndVisible()
//            navigationController.popToRootViewController(animated: true)
            
            
        }
        
        alertController.addAction(cancelAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
 func checkUserReviewStatus()
 {
     if let controller = UIStoryboard(name: "RideRating", bundle: nil).instantiateViewController(withIdentifier: "DriverMode1") as? DriverMode1 {
         if let window = self.window, let rootViewController = window.rootViewController {
             var currentController = rootViewController
             while let presentedController = currentController.presentedViewController {
                 currentController = presentedController
             }
             currentController.present(controller, animated: true, completion: nil)
         }
     }
     
     //
     
     
     let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
    // self.hudShow()
     ServiceClass.sharedInstance.hitServiceForGetReviewStatus(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
       //  self.hudHide()
         print_debug(parseData)
         if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
            // "type": "driver" OR  "type": "passenger"
             if (parseData["message"] != "No result found" ) {
                 var type = parseData["type"]
                 if type == "driver"{
                     print_debug("show Passenger reviews")
                     
                 }
                 else
                 {
                 print_debug("show driver reviews")
                 }
             }
         }
         else {
           //  self.hudHide()
             
         }
         
     })
 }
}

