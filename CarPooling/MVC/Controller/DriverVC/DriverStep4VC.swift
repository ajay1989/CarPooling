//
//  DriverStep4VC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 11/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverStep4VC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var btn_next: UIButton!
    
    @IBOutlet weak var viewCity1: UIView!
    @IBOutlet weak var viewCity2: UIView!
    @IBOutlet weak var viewCity3: UIView!
    @IBOutlet weak var viewCity4: UIView!
    @IBOutlet weak var viewCity5: UIView!
    // heightConstant
    @IBOutlet weak var viewCity1Height: NSLayoutConstraint!
    @IBOutlet weak var viewCity2Height: NSLayoutConstraint!
    @IBOutlet weak var viewCity3Height: NSLayoutConstraint!
    @IBOutlet weak var viewCity4Height: NSLayoutConstraint!
    @IBOutlet weak var viewCity5Height: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_city1: UILabel!
    @IBOutlet weak var lbl_city2: UILabel!
    @IBOutlet weak var lbl_city3: UILabel!
    @IBOutlet weak var lbl_city4: UILabel!
    @IBOutlet weak var lbl_city5: UILabel!
    
    
    
    @IBOutlet weak var ct_vwSearchTop: NSLayoutConstraint!
    @IBOutlet weak var view_Add: UIView!
    @IBOutlet weak var vw_searc1: UIView!{
        didSet{
            vw_searc1.borderWithShadow(radius: 6.0)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txt_search: UITextField!
    var searchTimer: Timer?
    var arr_city:Array = [City]()
     var arr_SelectedCity:NSMutableArray = ["0","0","0","0","0"]
     var index = -1
    var totalView:Int = 0
    var ride:Ride!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ride.from_city)
        print(ride.to_city)
        // Do any additional setup after loading the view.
       // Ignorer ->  Continuer
       // btn_next.setTitle("Ignorer👉🏻", for: .normal)
        txt_search.returnKeyType = .search
        txt_search.addTarget(self, action: #selector(typingName), for: .editingChanged)
        txt_search.autocorrectionType = .no
        self.tableView.isHidden = true
        //Button text  Ignorer
        self.hideNavigationController()
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        
        viewCity1Height.constant = 0
        viewCity2Height.constant = 0
        viewCity3Height.constant = 0
        viewCity4Height.constant = 0
        viewCity5Height.constant = 0
        
        
    }
    
    
    @objc func typingName(textField:UITextField){
       self.hudShow()
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeyword(_:)), userInfo: textField.text!, repeats: false)
        
    }
    @objc func searchForKeyword(_ timer: Timer) {
        self.arr_city.removeAll()
        self.tableView.isHidden = true
        self.tableView.reloadData()
       // self.continueDisable()
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
    // MARK: - Action method
    @IBAction func actionAddSearchViews()
    {
        if self.totalView < 5 {
             self.vw_searc1.isHidden = false
        }
      
        
    }
    @IBAction  func actionDeleteView(_ sender:UIButton)
    {
        self.totalView -= 1
        if sender.tag == 1
        {
            viewCity1Height.constant = 0
            arr_SelectedCity.replaceObject(at: 0, with: "0")
           // lbl_city1.text = city.city_name
            
        }
        else if (sender.tag == 2)
        {
            viewCity2Height.constant = 0
             arr_SelectedCity.replaceObject(at: 1, with: "0")
            //lbl_city2.text = city.city_name
        }
        else if (sender.tag == 3)
        {
            viewCity3Height.constant = 0
             arr_SelectedCity.replaceObject(at: 2, with: "0")
           // lbl_city3.text = city.city_name
        }
        else if (sender.tag == 4)
        {
            viewCity4Height.constant = 0
              arr_SelectedCity.replaceObject(at: 3, with: "0")
            //lbl_city4.text = city.city_name
        }
        else if (sender.tag == 5)
        {
            viewCity5Height.constant = 0
            arr_SelectedCity.replaceObject(at: 4, with: "0")
          //  lbl_city5.text = city.city_name
        }
        else
        {
            
        }
     //   btn_next.setTitle("Ignorer👉🏻", for: .normal)
       var p = 0
        var i = 0
        let arr = self.arr_SelectedCity.filter({$0 as! String != "0"})
        for data in arr {
            let data1 = data as! String
            if data1 != "0" {
                p = 1
            }
            
            i = i + 1
        }
        if p != 1
        {
            btn_next.setTitle("Ignorer👉🏻", for: .normal)
        }
        else
        {
             btn_next.setTitle("Continuer👉🏻", for: .normal)
           // self.btn_next.titleLabel?.text = "Continuer👉🏻"
        }
        
    }
    @IBAction func actionOpenAlert()
    {
        
        let otherAlert = UIAlertController(title: "", message: "En ajoutant une ville de passage, tu augmentes tes chances de trouver un covoitureur et tu aides la communauté en plus!", preferredStyle: UIAlertController.Style.actionSheet)
        let dismiss = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        otherAlert.addAction(dismiss)
        present(otherAlert, animated: true, completion: nil)
    }
 
    @IBAction func actionBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionTest(sender: UIButton)
    {
        print(self.arr_SelectedCity) // remove 0 and save selected cities to ride model
        var str = ""
        var i = 0
        let arr = self.arr_SelectedCity.filter({$0 as! String != "0"})
        for data in arr {
            let data1 = data as! String
            if data1 != "0" {
                if i == arr.count - 1 {
                    str = "\(str)\(data1)"
                }
                else {
                    str = "\(str)\(data1),"
                }
            }
            i = i + 1
        }
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep5VC = storyboard.instantiateViewController(withIdentifier: "DriverStep5VC") as! DriverStep5VC
        ride.station = str
        vc.ride = self.ride
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func createCityLabel(city:City,xVal:Int,yVal:Int)
  {
    self.btn_next.setTitle("Continuer👉🏻", for: .normal)
//self.btn_next.titleLabel?.text = "Continuer👉🏻"
    self.totalView += 1
    if self.totalView == 1
    {
        viewCity1Height.constant = 20
        lbl_city1.text = city.city_name
         arr_SelectedCity.replaceObject(at: 0, with: city.city_id)
        
    }
    else if (self.totalView == 2)
    {
        viewCity2Height.constant = 20
        lbl_city2.text = city.city_name
        arr_SelectedCity.replaceObject(at: 1, with: city.city_id)
    }
    else if (self.totalView == 3)
    {
        viewCity3Height.constant = 20
       lbl_city3.text = city.city_name
        arr_SelectedCity.replaceObject(at: 2, with: city.city_id)
    }
    else if (self.totalView == 4)
    {
        viewCity4Height.constant = 20
        lbl_city4.text = city.city_name
        arr_SelectedCity.replaceObject(at: 3, with: city.city_id)
    }
    else if (self.totalView == 5)
    {
        viewCity5Height.constant = 20
        lbl_city5.text = city.city_name
        arr_SelectedCity.replaceObject(at: 4, with: city.city_id)
    }
    else
    {
        
    }
//    let Searchview:UIView = UIView.init(frame: CGRect(x: xVal, y: yVal, width: Int(self.vw_searc1.frame.width), height: 50))
//    let lables:UILabel = UILabel.init(frame:CGRect(x: Searchview.frame.minX + 20, y: 0, width: 100, height: 20))
//    lables.textColor = UIColor.gray
//    lables.text = city.city_name
//    Searchview.addSubview(lables)
//    let deleteBtn:UIButton = UIButton.init(frame:CGRect(x: Searchview.frame.maxX - 20, y: 0, width: 20, height: 20))
//    deleteBtn.setImage(UIImage.init(named: "tick_cross"), for: .normal)
//    deleteBtn.tag = totalView
//    Searchview.tag = totalView
//    deleteBtn.addTarget(self, action: #selector(actionDeleteView(_:)), for: .touchUpInside)
//    Searchview.addSubview(deleteBtn)
//
//   // Searchview.backgroundColor = UIColor.gray
//    self.view.addSubview(Searchview)
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
           // txt_search.text = data.city_name!
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
         let data = self.arr_city[indexPath.row]
        self.tableView.isHidden = true
       
    self.createCityLabel(city: data, xVal: 15, yVal: 0)
      //  self.ct_vwSearchTop.constant = self.ct_vwSearchTop.constant + self.vw_searc1.frame.height + 10
        self.vw_searc1.isHidden = true
          self.index = -1
        self.txt_search.text = ""
        //self.continueEnable()
    }
}
