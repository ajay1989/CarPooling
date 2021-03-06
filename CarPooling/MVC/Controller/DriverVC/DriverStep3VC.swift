//
//  DriverStep3VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 01/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep3VC: BaseViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
          vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    @IBOutlet weak var btn_continue: UIButton!
    var arr_city:Array = [City]()
    var index = -1
    @IBOutlet weak var tableView: UITableView!
    fileprivate var dataTask:URLSessionDataTask?
    @IBOutlet weak var txt_search: UITextField!
     var ride:Ride!
    var searchTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_search.returnKeyType = .search
        txt_search.autocorrectionType = .no
        txt_search.addTarget(self, action: #selector(typingName), for: .editingChanged)
        self.tableView.isHidden = true
        self.continueDisable()
        // Do any additional setup after loading the view.
        self.hideNavigationController()
        // Do any additional setup after loading the view.
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
    }
    

    // MARK: - CustomAction method
   
    @IBAction func actionNext(sender: UIButton)
    {
        
        if self.arr_city.count > 0 {
            let data = self.arr_city[self.index]
            self.ride.to_city = data.city_id!
            self.ride.to_city_lat = data.city_lat!
            self.ride.to_city_lng = data.city_lng!
            
            
            //Missing step 4
            let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
            let vc: DriverStep4VC = storyboard.instantiateViewController(withIdentifier: "DriverStep4VC") as! DriverStep4VC
            vc.ride = self.ride
            // self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        
        
        
        
    }
    
    
    @objc func typingName(textField:UITextField){
         self.hudShow()
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        
        // reschedule the search: in 1.0 second, call the searchForKeyword method on the new textfield content
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeyword(_:)), userInfo: textField.text!, repeats: false)
        
    }
    @IBAction func actionBack()
    {
        self.navigationController?.popViewController(animated: true)
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
                 self.hudHide()
            }
            
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
