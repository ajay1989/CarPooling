//
//  EditUserProfileVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 10/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout

import UIKit
import IGColorPicker
class EditUserProfileVC: BaseViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tblvw_CarDetail: UITableView!{
        didSet{
            tblvw_CarDetail.delegate = self
            tblvw_CarDetail.dataSource = self
        }
        
    }
    var arr_cars:Array = [Car]()
    @IBOutlet weak var btnUserProfileView: UIButton!
    
    @IBOutlet weak var vw_UserInfo: UIView!
    
    @IBOutlet weak var vw_CarInfo: UIView!
    var arr_comments = [Comment]()
    @IBOutlet weak var btnCarInfoView: UIButton!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_mobile: UITextField!
    @IBOutlet weak var txt_dob: UITextField!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var txt_lname: UITextField!
    @IBOutlet weak var txt_fname: UITextField!
    @IBOutlet weak var imgUser: UIImageView!
    var gender = "Male"
    var pickerController = UIImagePickerController()
    var customDatePicker:ActionSheetStringPicker = ActionSheetStringPicker.init()
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        imgUser.cornerRadius = 45
         showDatePicker()
        btnUserProfileView.borderColor =  UIColor.init(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0)
        btnUserProfileView.titleLabel?.textColor = UIColor.black
        
        btnCarInfoView.borderColor = UIColor.lightGray
        btnCarInfoView.titleLabel?.textColor = UIColor.lightGray
        
        vw_CarInfo.isHidden = true
        vw_UserInfo.isHidden = false
        
        
    
        
        self.loadUser()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadCars()
    }
    
    
    @IBAction func goToBack(sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionChangeView(sender: UIButton)
    {
        
        if sender.tag == 1
        {
            btnUserProfileView.borderColor =  UIColor.init(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0)
            btnUserProfileView.titleLabel?.textColor = UIColor.black
            
            btnCarInfoView.borderColor = UIColor.lightGray
             btnCarInfoView.titleLabel?.textColor = UIColor.lightGray
            
            vw_CarInfo.isHidden = true
            vw_UserInfo.isHidden = false
            
        }
        else
        {
            btnCarInfoView.borderColor =  UIColor.init(red: 88.0/255.0, green: 182.0/255.0, blue: 157.0/255.0, alpha: 1.0)
            btnCarInfoView.titleLabel?.textColor = UIColor.black
            
            btnUserProfileView.borderColor = UIColor.lightGray
            btnUserProfileView.titleLabel?.textColor = UIColor.lightGray
            
            vw_UserInfo.isHidden = true
            vw_CarInfo.isHidden = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func loadUser() {
        let params = ["keyword":AppHelper.getStringForKey(ServiceKeys.user_id)]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForGetUserDetail(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            print_debug(parseData)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let basic = parseData["data"]["basic"].arrayValue
                let comments = parseData["data"]["comment"].arrayValue
                for data in basic {
                    let user = User.init(fromJson: data)
                    let url = URL(string: "\(ServiceUrls.profilePicURL)\(user.profile_photo!)")!
                    let placeholderImage = UIImage(named: "Male-driver")!
                    
                    self.imgUser.af_setImage(withURL: url, placeholderImage: placeholderImage)
                    //self.lbl_name.text = "\(user.first_name!) \(user.last_name!)"
                    self.txt_mobile.text = user.mobile_number
                    self.txt_email.text = user.user_email
                    self.txt_dob.text = user.dob
                    self.txt_fname.text = user.first_name
                    self.txt_lname.text = user.last_name
                    self.gender = user.gender
                }
                for comment in comments {
                    let commentData = Comment.init(fromJson: comment)
                    self.arr_comments.append(commentData)
                }
                
            }
            else {
                self.hudHide()
                
            }
            
        })
    }
    
    func loadCars() {
        self.arr_cars.removeAll()
        //        self.tableView.reloadData()
       
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
                        self.tblvw_CarDetail.reloadData()
                    }
                }
            }
            else {
                self.hudHide()
                
            }
            
        })
        
    }
    
    
    @IBAction func btn_updateProfile_tap(_ sender: Any) {
        var imageData = Data()
        imageData = imgUser.image!.jpeg(.low)!
        let params = ["first_name":self.txt_fname.text!,
                      "last_name":self.txt_lname.text!,
                      "mobile_number":self.txt_mobile.text!,
                      "gender":self.gender,
                      "dob":self.txt_dob.text!] as [String : String]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForUpdateProfileImage(params, data: imageData, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            self.hudHide()
            print_debug(parseData)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
               
                self.navigationController?.popViewController(animated: true)
                
                
            }
            else {
                self.hudHide()
                
            }
            
        })
    }
    
    
    @IBAction func btn_imgProfile_tap(_ sender: Any) {
        let alertViewController = UIAlertController(title: "", message: NSLocalizedString("Choose your option", comment: ""), preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: { (alert) in
            self.openCamera()
        })
        let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default) { (alert) in
            self.openGallary()
        }
        let cancel = UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: .cancel) { (alert) in
            
        }
        alertViewController.addAction(camera)
        alertViewController.addAction(gallery)
        alertViewController.addAction(cancel)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func btn_addcar_tap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: CarModelSelectionVC = storyboard.instantiateViewController(withIdentifier: "CarModelSelectionVC") as! CarModelSelectionVC
        // self.present(vc, animated: true, completion: nil)
        vc.isFromEdit = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            pickerController.delegate = self
            self.pickerController.sourceType = UIImagePickerController.SourceType.camera
            pickerController.allowsEditing = true
            self .present(self.pickerController, animated: true, completion: nil)
        }
        else {
            let alertWarning = UIAlertView(title:NSLocalizedString("Warning", comment: ""), message: NSLocalizedString("You don't have camera", comment: ""), delegate:nil, cancelButtonTitle:NSLocalizedString("OK", comment: ""), otherButtonTitles:"")
            alertWarning.show()
        }
    }
    func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage]! as! UIImage
        self.imgUser.image = image
        
        dismiss(animated:true, completion: nil)
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txt_dob.inputAccessoryView = toolbar
        txt_dob.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txt_dob.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
        
    }
    
    @objc func btn_delete_tap(_ sender: UIButton) {
        let id = sender.tag
        
        //        self.tableView.reloadData()
        
        
    }
    
    @objc func btn_edit_tap(_ sender: UIButton) {
        
        
        
        let id = sender.tag
        
        
        
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: CarInfoVC = storyboard.instantiateViewController(withIdentifier: "CarInfoVC") as! CarInfoVC
        let data = self.arr_cars[id]
        vc.txt_brandName = "\(data.brand_name!) - \(data.model_name!)"
        vc.txt_modelID = data.model_id
        vc.isFromCarEdit = true
        vc.arr_cars = data
        vc.isFromEdit = true
        // self.present(vc, animated: true, completion: nil)
        self.present(vc, animated: true) {
            
        }
        
        //        self.tableView.reloadData()
        
        
    }
}
extension EditUserProfileVC : UITableViewDataSource, UITableViewDelegate {
    
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
       return self.arr_cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if placeArray.count > 0 {
        let data = self.arr_cars[indexPath.row]
        let cell = tblvw_CarDetail.dequeueReusableCell(withIdentifier: "CarDetailsTableViewCell", for: indexPath) as! CarDetailsTableViewCell
      //  cell.carColorPickerView.delegate = self
        var tempColor = [UIColor]()
        
     
        
        for i in 0..<appDelegate.arr_color.count {
            let color1 = appDelegate.arr_color[i]
            let col = hexStringToUIColor(hex: color1.color_name!)
            tempColor.append(col)
            if data.color! == color1.color_name! {
                cell.carColorPickerView.preselectedIndex = i
            }
        }
//        cell.carColorPickerView.colors = tempColor
        cell.txt_number1.text = data.vehicle_number_one
        cell.txt_number2.text = data.vehicle_number_two
        cell.txt_number3.text = data.vehicle_number_three
        cell.lbl_carName.text = "\(data.brand_name!) \(data.model_name!)"
        cell.txt_date.text = data.insurance_expire_date
        cell.btn_Delete.addTarget(self, action: #selector(btn_delete_tap(_:)), for: .touchUpInside)
        cell.btn_Delete.tag = indexPath.row
        
        cell.btn_edit.addTarget(self, action: #selector(btn_edit_tap(_:)), for: .touchUpInside)
        cell.btn_edit.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
        // }
        //p;return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 258
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc:BookingDetailVC = storyboard.instantiateViewController(withIdentifier: "BookingDetailVC") as! BookingDetailVC
//        // self.present(vc, animated: true, completion: nil)
//
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
