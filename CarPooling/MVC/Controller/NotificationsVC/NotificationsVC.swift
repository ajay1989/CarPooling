//
//  NotificationsVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 19/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var img_profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(AppHelper.getValueForKey(ServiceKeys.profile_image)!)")!
        
        let placeholderImage = UIImage(named: "Male-driver")!
        
        self.img_profilePic.af_setImage(withURL: url, placeholderImage: placeholderImage)
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

}
