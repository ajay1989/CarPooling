//
//  DriverStep1VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 01/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
import Alamofire
class DriverStep1VC: BaseViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var btn_continue: UIButton!
    var arr_city:Array = [City]()
    var index = -1
    @IBOutlet weak var tableView: UITableView!
    fileprivate var dataTask:URLSessionDataTask?
    @IBOutlet weak var txt_search: UITextField!
    var searchTimer: Timer?
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)

        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_search.returnKeyType = .search
        txt_search.addTarget(self, action: #selector(typingName), for: .editingChanged)
        txt_search.autocorrectionType = .no
        self.tableView.isHidden = true
        self.continueDisable()
        // Do any additional setup after loading the view.
        self.hideNavigationController()
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
    }
    @IBAction func actionBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func typingName(textField:UITextField){
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        
        // reschedule the search: in 1.0 second, call the searchForKeyword method on the new textfield content
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeyword(_:)), userInfo: textField.text!, repeats: false)
        
    }
    
    @objc func searchForKeyword(_ timer: Timer) {
        self.arr_city.removeAll()
        self.tableView.isHidden = true
        self.tableView.reloadData()
        self.continueDisable()
        let keyword = txt_search.text!
        if keyword.characters.count != 0 {
            
            self.arr_city = appDelegate.arr_city.filter({$0.city_name.lowercased().hasPrefix(keyword.lowercased())})
            if(self.arr_city.count > 0) {
                print(self.arr_city)
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    
    // MARK: - CustomAction method
    @IBAction func actionNext(sender: UIButton)
    {
        if self.arr_city.count > 0 {
            let data = self.arr_city[index]
            let ride = Ride(fromJson: JSON.init(rawValue: ""))
            ride.device_type = "3"
            ride.user = AppHelper.getStringForKey(ServiceKeys.user_id)
            ride.from_city = data.city_id!
            ride.from_city_lat = data.city_lat!
            ride.from_city_lng = data.city_lng!
            ride.from_city_address = ""
            let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
            let vc: DriverStep2VC = storyboard.instantiateViewController(withIdentifier: "DriverStep2VC") as! DriverStep2VC
            vc.ride = ride
            self.navigationController?.pushViewController(vc, animated: true)
        }
  
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_city.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let data = self.arr_city[indexPath.row]
        if index == indexPath.row {
            cell.img_tick.isHidden = false
            txt_search.text = data.city_name!
        }
        else {
            cell.img_tick.isHidden = true
        }
        cell.img_icon.image = UIImage(named: "img_location")
        cell.selectionStyle = .none
        cell.lbl_text.text = data.city_name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        self.tableView.reloadData()
        self.continueEnable()
    }
    
    func continueEnable() {
        btn_continue.isEnabled = true
        btn_continue.setTitle("Continuer👉", for: .normal)
        btn_continue.setTitleColor(UIColor.black, for: .normal)
    }
    
    func continueDisable() {
        btn_continue.isEnabled = false
        btn_continue.setTitle("Continuer👉🏼", for: .normal)
        btn_continue.setTitleColor(UIColor.lightGray, for: .normal)
    }

}

