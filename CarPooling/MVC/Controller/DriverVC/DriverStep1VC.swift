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
    var arr_city:Array = [[String:String]]()
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
        self.tableView.isHidden = true
        self.continueDisable()
        // Do any additional setup after loading the view.
        self.hideNavigationController()
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
            
            
            let urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=\(txt_apiKey)&language=en&sensor=true&region=GB&input=\(keyword)"
            print(urlString)
            let s = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
            s.addCharacters(in: "+&")
            if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: s as CharacterSet) {
                if let url = URL(string: encodedString) {
                    let request = URLRequest(url: url)
                    self.hudShow()
                    dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                        self.hudHide()
                        if let data = data{
                            do{
                                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                                if let status = result["status"] as? String{
                                    if status == "OK"{
                                        if let predictions = result["predictions"] as? NSArray{
                                            
                                            for dict in predictions as! [NSDictionary]{
                                                let structuredFormatting = dict["structured_formatting"] as! NSDictionary
                                                let emptyDict = ["place_id" : dict["place_id"] as! String,
                                                                 "main_text" : structuredFormatting["main_text"] as! String,
                                                                 "secondary_text" : structuredFormatting["secondary_text"] as! String,
                                                                 "description" : dict["description"] as! String]
                                                self.arr_city.append(emptyDict)
                                            }
                                            DispatchQueue.main.async(execute: { () -> Void in
                                                if(self.arr_city.count > 0) {
                                                    print(self.arr_city)
                                                    self.tableView.isHidden = false
                                                    self.tableView.reloadData()
                                                }
                                            })
                                            return
                                        }
                                    }
                                }
                                DispatchQueue.main.async(execute: { () -> Void in
                                    //self.searchTextField.autoCompleteStrings = nil
                                })
                            }
                            catch let error as NSError{
                                print_debug("Error: \(error.localizedDescription)")
                            }
                        }
                    })
                    dataTask?.resume()
                }
            }
            
        }
    }
    
    
    
    // MARK: - CustomAction method
    @IBAction func actionNext(sender: UIButton)
    {
        if self.arr_city.count > 0 {
            let data1 = self.arr_city[self.index]
            let urlString = "https://maps.googleapis.com/maps/api/place/details/json?key=\(txt_apiKey)&placeid=\(data1["place_id"]!)"
            print(urlString)
            let s = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
            s.addCharacters(in: "+&")
            if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: s as CharacterSet) {
                if let url = URL(string: encodedString) {
                    let request = URLRequest(url: url)
                    self.hudShow()
                    dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                        self.hudHide()
                        if let data = data{
                            do{
                                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                                if let status = result["status"] as? String{
                                    if status == "OK"{
                                        let result1 = result["result"] as! NSDictionary
                                        let geometry = result1["geometry"] as! NSDictionary
                                        let location = geometry["location"] as! NSDictionary
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            let ride = Ride(fromJson: JSON.init(rawValue: ""))
                                            ride.from_city = data1["main_text"]!
                                            ride.from_city_lat = "\(location["lat"]!)"
                                            ride.from_city_lng = "\(location["lng"]!)"
                                        ride.from_city_address = data1["description"]!
                                            let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
                                            let vc: DriverStep2VC = storyboard.instantiateViewController(withIdentifier: "DriverStep2VC") as! DriverStep2VC
                                            vc.ride = ride
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        })
                                    }
                                }
                                
                            }
                            catch let error as NSError{
                                print_debug("Error: \(error.localizedDescription)")
                            }
                        }
                    })
                    dataTask?.resume()
                }
            }
        }
  
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_city.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if( !(cell != nil))
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        }
        let data = self.arr_city[indexPath.row]
        cell!.textLabel?.text = data["main_text"]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        self.continueEnable()
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

}

