//
//  PassengerListRequestVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 02/02/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//

import UIKit

class PassengerListRequestVC: UIViewController {
 @IBOutlet weak var tblVwPassengerList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func actionGoBack()
    {
        self.navigationController?.popViewController(animated: true)
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
//MARK: Passenger Tableview delegates
extension PassengerListRequestVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if self.arr_rides.count>0 {
        //            return self.arr_rides.count
        //        }
        //        else{
        //            return 0
        //
        //        }
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if placeArray.count > 0 {
        let cell = tblVwPassengerList.dequeueReusableCell(withIdentifier: "PassengerListTableViiewCell", for: indexPath) as! PassengerListTableViiewCell
       // cell.btn_contact.addTarget(self, action: #selector(self.showContactView(_:)), for: .touchUpInside)
        return cell
        // }
        //p;return UITableViewCell()
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc:BookingDetailVC = storyboard.instantiateViewController(withIdentifier: "BookingDetailVC") as! BookingDetailVC
        //        // self.present(vc, animated: true, completion: nil)
        //       // vc.rideDetail = self.arr_rides[indexPath.row]
        //  self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
