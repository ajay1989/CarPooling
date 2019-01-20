//
//  CarModelSelectionVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 14/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class CarModelSelectionVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
            vw_Search.borderWithShadow(radius: 6.0)
        }
    }
    var isFromEdit = false
    @IBOutlet weak var btn_continue: UIButton!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var arr_model:Array = [Model]()
    var index = -1
    var searchTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_search.returnKeyType = .search
        txt_search.autocorrectionType = .no
        txt_search.addTarget(self, action: #selector(typingName), for: .editingChanged)
        // Do any additional setup after loading the view.
        self.continueDisable()
        // Do any additional setup after loading the view.
        self.hideNavigationController()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        self.loadModel()
        
    }
    // api model    /get

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func typingName(textField:UITextField){
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        
        // reschedule the search: in 1.0 second, call the searchForKeyword method on the new textfield content
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeyword(_:)), userInfo: textField.text!, repeats: false)
        
    }
    
    @objc func searchForKeyword(_ timer: Timer) {
        
        self.loadModel()
        
        
    }
    
    func loadModel() {
        self.arr_model.removeAll()
//        self.tableView.reloadData()
        self.continueDisable()
        let keyword = txt_search.text!
        let params = ["keyword":keyword]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetModel(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                for data in parseData["data"]{
                    let model = Model.init(fromJson: data.1)
                    self.arr_model.append(model)
                }
                if self.arr_model.count>0 {
                    self.tableView.reloadData()
                }
            }
            else {
                self.arr_model.removeAll()
                self.tableView.reloadData()
            }
            
        })
    }

    
    @IBAction func btn_continue_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: CarInfoVC = storyboard.instantiateViewController(withIdentifier: "CarInfoVC") as! CarInfoVC
        let data = self.arr_model[index]
        vc.txt_brandName = "\(data.brand_name!) - \(data.model_name!)"
        vc.txt_modelID = data.model_id
        vc.isFromEdit = self.isFromEdit
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let data = self.arr_model[indexPath.row]
        if index == indexPath.row {
            cell.img_tick.isHidden = false
        }
        else {
            cell.img_tick.isHidden = true
        }
        cell.img_icon.image = UIImage(named: "IOScar_right")
        cell.selectionStyle = .none
        cell.lbl_text.text = "\(data.brand_name!) - \(data.model_name!)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        self.tableView.reloadData()
        self.continueEnable()
    }
}
