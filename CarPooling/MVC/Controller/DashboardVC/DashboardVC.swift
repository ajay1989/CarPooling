//
//  DashboardVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 20/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DashboardVC: BaseViewController {
    @IBOutlet weak var tblVw: UITableView!
   
    
    @IBOutlet weak var searchBar: UISearchBar!
    var arrData = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)        // Do any additional setup after loading the view.
        tblVw.delegate = self
        tblVw.dataSource = self
        self.loadUserData()
    }
    
    func loadUserData() {
        let params: [String : String] = ["id":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForProfile(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let user = UserData.init(fromJson: parseData["data"])
                
                
            }
            else {
                self.makeToast(errorDict!["errMessage"] as! String)
            }
            
        })
    }
    
}
    //MARK:- UIableView Data Source & Delegates Methods
    
    extension DashboardVC : UITableViewDataSource, UITableViewDelegate {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if self.arrData.count>0 {
                return self.arrData.count
            }
            else{
                return 03}
            //placeArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // if placeArray.count > 0 {
            let cell = tblVw.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell
             cell.vw_base.layer.cornerRadius = 15
            cell.vw_base.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
            cell.vw_green.clipsToBounds = true
            cell.vw_green.layer.cornerRadius = 15
            if #available(iOS 11.0, *) {
                cell.vw_green.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
            // border
//             cell.vw_base.layer.borderWidth = 1.0
//             cell.vw_base.layer.borderColor = UIColor.lightGray.cgColor
//            cell.vw_base.layer.shadowColor = UIColor.blue.cgColor
//
//            cell.vw_base.layer.shadowOffset = CGSize(width: 20, height: 10)
//          //  cell.vw_base.layer.shadowOpacity = 0.7
//            //cell.vw_base.layer.shadowRadius = 4.0
//            //            let model: DataDetailsModel = self.arrData[indexPath.row] as! DataDetailsModel
//
//            //"all","running","stop","idle","pulling","all","all","all"
          
           
            
           
            
            return cell
            // }
            //p;return UITableViewCell()
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 165
        }
        

}
extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
//        layer.masksToBounds = false
//        layer.shadowOffset = offset
//        layer.shadowColor = color.cgColor
//        layer.shadowRadius = radius
//        layer.shadowOpacity = opacity
//
//        let backgroundCGColor = backgroundColor?.cgColor
//        backgroundColor = nil
//        layer.backgroundColor =  backgroundCGColor
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 6.0
        layer.masksToBounds = false
         backgroundColor = UIColor.white
    }
}
