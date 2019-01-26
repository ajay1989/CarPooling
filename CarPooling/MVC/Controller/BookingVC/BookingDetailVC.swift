//
//  BookingDetailVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 29/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class BookingDetailVC: UIViewController {
    
    @IBOutlet weak var lbl_From: UILabel!
    
    @IBOutlet weak var lbl_To: UILabel!
    @IBOutlet weak var lbl_DateFrom: UILabel!
    @IBOutlet weak var lbl_DateTo: UILabel!
    @IBOutlet weak var lbl_seat: UILabel!
    @IBOutlet weak var lbl_Lugguage: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    
    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var lbl_tripName: UILabel!
    
    @IBOutlet weak var img_User: UIImageView!
    
    @IBOutlet weak var lbl_userNAmeAge: UILabel!
  @IBOutlet  var arrRank:[UIImageView]!
    
    var rideDetail: Ride!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        lbl_From.text = ""
//        
//        lbl_To.text = ""
//         lbl_DateFrom.text = ""
//        lbl_DateTo.text = ""
//         lbl_seat.text = ""
//        lbl_Lugguage.text = ""
//         lbl_Price.text = ""
//        
//      lbl_Distance.text = ""
//         lbl_tripName.text = ""
//        
//        img_User.image = UIImage.init(named: "")
        
       //  lbl_userNAmeAge: UILabel!
    }
    
    //MARK: Action method
    @IBAction func actionBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
