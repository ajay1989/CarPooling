//
//  DriverStep7VC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 11/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep7VC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var arr_cars:Array = [Car]()
    @IBOutlet weak var btn_continue: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    var index = -1
    var ride:Ride!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadCars()
    }
    
    func loadCars() {
        self.arr_cars.removeAll()
        //        self.tableView.reloadData()
        self.continueDisable()
        let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetCars(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                
                if (parseData["message"] != "No result found" ) {
                for data in parseData["data"]{
                    let model = Car.init(fromJson: data.1)
                    self.arr_cars.append(model)
                }
                if self.arr_cars.count>0 {
                    self.tableView.reloadData()
                }
                }
            }
            else {
                self.hudHide()

            }
            
        })
        
    }
    
    

    @IBAction func btn_continue_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep8VC = storyboard.instantiateViewController(withIdentifier: "DriverStep8VC") as! DriverStep8VC
        let data = self.arr_cars[self.index]
        self.ride.vehicle = data.vehicle_id
        vc.ride = self.ride
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btn_add_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: CarModelSelectionVC = storyboard.instantiateViewController(withIdentifier: "CarModelSelectionVC") as! CarModelSelectionVC
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_cars.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let data = self.arr_cars[indexPath.row]
        if index == indexPath.row {
            cell.img_tick.isHidden = false
        }
        else {
            cell.img_tick.isHidden = true
        }
        cell.img_icon.image = UIImage(named: "IOScar_right")
        cell.selectionStyle = .none
        cell.lbl_text.text = "\(data.brand_name!) \(data.model_name!) (\(data.vehicle_number_one!)-\(data.vehicle_number_two!)-\(data.vehicle_number_three!))"
        return cell
        
        
    }
    
    func continueEnable() {
        btn_continue.isEnabled = true
        btn_continue.setTitle("Continue👉", for: .normal)
        btn_continue.setTitleColor(UIColor.black, for: .normal)
    }
    
    func continueDisable() {
        btn_continue.isEnabled = false
        btn_continue.setTitle("Continue👉🏼", for: .normal)
        btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        self.tableView.reloadData()
        self.continueEnable()
    }
}
