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
        self.loadCars()
        // Do any additional setup after loading the view.
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
                
                for data in parseData["data"] {
                    let user = User.init(fromJson: data.1)
                    let url = URL(string: "https://i.stack.imgur.com/dWrvS.png")!
                    let placeholderImage = UIImage(named: "Male-driver")!
                    
                    self.imgUser.af_setImage(withURL: url, placeholderImage: placeholderImage)
                    self.lbl_name.text = "\(user.first_name!) \(user.last_name!)"
                    self.txt_mobile.text = user.mobile_number
                    self.txt_email.text = user.user_email
                    self.txt_dob.text = user.dob
                    self.txt_fname.text = user.first_name
                    self.txt_lname.text = user.last_name
                    self.gender = user.gender
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
                      "dob":self.txt_dob.text!,
                      "profile_photo":imageData] as [String : Any]
        self.hudShow()
        ServiceClass.sharedInstance.hitServiceForUpdateUserDetail(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
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
}
extension EditUserProfileVC : UITableViewDataSource, UITableViewDelegate,ColorPickerViewDelegateFlowLayout {
    
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
        cell.carColorPickerView.layoutDelegate = self
        cell.carColorPickerView.isSelectedColorTappable = false
        cell.carColorPickerView.style = .circle //.square
        cell.carColorPickerView.selectionStyle = .check
        cell.carColorPickerView.backgroundColor = .clear
       cell.carColorPickerView.preselectedIndex = 3
        cell.txt_number1.text = data.vehicle_number_one
        cell.txt_number2.text = data.vehicle_number_two
        cell.txt_number3.text = data.vehicle_number_three
        cell.lbl_carName.text = "\(data.brand_name!) \(data.model_name!)"
        cell.txt_date.text = data.insurance_expire_date
        cell.btn_Delete.addTarget(self, action: #selector(btn_delete_tap(_:)), for: .touchUpInside)
        cell.btn_Delete.tag = indexPath.row
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
    // MARK: - ColorPickerViewDelegateFlowLayout
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 18, height: 18
        )
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
