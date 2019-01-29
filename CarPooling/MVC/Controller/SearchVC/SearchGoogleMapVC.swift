//
//  SearchGoogleMapVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 23/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
import GoogleMaps
class SearchGoogleMapVC: BaseViewController {
 @IBOutlet weak var mapView : GMSMapView!
    // MARK: - IBOutlet and Variables
    
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var bottomTablePlaces : NSLayoutConstraint!
    @IBOutlet weak var btnGo : UIButton!
    @IBOutlet weak var tablePlaces : UITableView!
    @IBOutlet weak var txtFromPlace : UITextField!
    @IBOutlet weak var txtToPlace : UITextField!
    var cityArray :NSArray = []
    
    var filteredArray = [String]()
    
    var shouldShowSearchResults = false
    
    
    var isFromTxtActive : Bool = false
    var arrPlaces : [Places]!
    var fromLatLong : CLLocationCoordinate2D!
    var toLatLong : CLLocationCoordinate2D!
    
    var locationManager = CLLocationManager()
    var currentLatLong : CLLocationCoordinate2D!
    override func viewDidLoad() {
        super.viewDidLoad()
         let path = Bundle.main.path(forResource: "city", ofType: "json")
        
        let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        let convertedString = String(data: jsonData! as Data, encoding: String.Encoding.utf8)
        print(convertedString ?? "")
        
        var dictonary:NSDictionary?
        
        if let data = jsonData {
            
            do {
                dictonary = try JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:AnyObject] as! NSDictionary
                cityArray = dictonary?.value(forKey: "data") as! NSArray
//                cityArray = err.flatMap { $0 ["city"] }
  
                if let myDictionary = dictonary
                {
                    
                    print(" all cities: \(myDictionary["data"]!)")
                }
            } catch let error as NSError {
                print(error)
            }
        }
        
        
        
        
        
      
        
        btn_next.isHidden = true
        tablePlaces.isHidden = true
        btnGo.isEnabled = false
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
//        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification,object: nil)
//        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHide),name: UIResponder.keyboardWillHideNotification,object: nil)
        if (currentLatLong == nil) {
            txtFromPlace.becomeFirstResponder()
        } else {
            txtFromPlace.text = "Your current location"
            fromLatLong = currentLatLong
            txtToPlace.becomeFirstResponder()
        }
    }
    //MARK: Action method
    @IBAction func btnDoneAction() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let researchResultVC: ResearchResultVC = storyboard.instantiateViewController(withIdentifier: "ResearchResultVC") as! ResearchResultVC
        self.navigationController?.pushViewController(researchResultVC, animated: true)
//        if fromLatLong != nil && toLatLong != nil {
//            //self.btnBackAction()
//            tablePlaces.isHidden = true
//            self.addMarkerAndDrawPloyline(from: fromLatLong, to: toLatLong)
//        }
       
    }
    @IBAction func actionClearMap()
    {
        self.btn_next.isHidden = false
        btnGo.isEnabled = false
        //ResearchResultVC
        mapView.clear()
        txtToPlace.text = ""
        txtFromPlace.text = ""
        self.btn_next.isHidden = true
    }
    @IBAction func actiongoBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func resetTablePlaces() {
        self.arrPlaces = nil
        self.tablePlaces.reloadData()
        tablePlaces.isHidden = true
    }
    func addFromMarker(location: CLLocationCoordinate2D, address: String, shortAddress: String) {
        mapView.clear()
        mapView.addMarker(location: location, address: address, shortAddress: shortAddress)
    }
    
    func addToMarker(location: CLLocationCoordinate2D, address: String, shortAddress: String) {
        mapView.addMarker(location: location, address: address, shortAddress: shortAddress)
    }
    
    func addMarkerAndDrawPloyline(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        tablePlaces.isHidden = true //archit
        GoogleApiManager.polylineRoute(from: from, to: to, on: self.mapView) { (arrRouteLatLong) in
            _ = CarMarker.init(mapView: self.mapView, routeLatLongs: arrRouteLatLong)
        }
    }
    
    func dismissSearchPlacesListVC() {
        //self.btnWhereToGo.isHidden = false
        tablePlaces.isHidden = true
    }
}
    // MARK: - CLLocationManagerDelegate Delegate
    extension SearchGoogleMapVC : CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLocation = locations.last
            mapView.clear()
            currentLatLong = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
            mapView.addMarker(location: currentLatLong, address: "", shortAddress: "")
            self.locationManager.stopUpdatingLocation()
        }
    }

//
// MARK: - Keyboard Notification methods
extension SearchGoogleMapVC {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomTablePlaces.constant = keyboardHeight + 10
            tablePlaces.isHidden = false
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        bottomTablePlaces.constant = 10
        tablePlaces.isHidden = true
    }
}

// MARK: - UITextFieldDelegate Delegate
extension SearchGoogleMapVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text! == "") {
            self.resetTablePlaces()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.txtFromPlace) {
            self.txtToPlace.becomeFirstResponder()
        } else {
            self.btnDoneAction()
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.resetTablePlaces()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        (textField == txtFromPlace) ? (isFromTxtActive=true) : (isFromTxtActive=false)
        
        var completeTextForSearch : String = textField.text!+string
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        let minSearchCharRange = 3
        if (isBackSpace == -92) {
            if (completeTextForSearch.count>0) {
                completeTextForSearch = completeTextForSearch.substring(to: completeTextForSearch.index(before: completeTextForSearch.endIndex))
            }
        }
        
        if completeTextForSearch.count > minSearchCharRange {
            GoogleApiManager.placesOf(searchText: textField.text!) { (status, places) in
                if status {
                    self.arrPlaces = places
                    self.tablePlaces.reloadData()
                    self.tablePlaces.isHidden = false
                }
            }
        }
        return true
    }
}

// MARK: - UITableViewDelegate Delegate
extension SearchGoogleMapVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0;//Choose your custom row height
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if (arrPlaces != nil) {
            return arrPlaces.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell")!
        let lblPlace : UILabel = cell.viewWithTag(111) as! UILabel
        lblPlace.text = arrPlaces[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        GoogleApiManager.latLongFrom(placeId: arrPlaces[indexPath.row].placeId) { (status, location) in
            if status {
                let latLong = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                switch self.isFromTxtActive {
                case true:
                    self.fromLatLong = latLong
                    self.txtFromPlace.text = self.arrPlaces[indexPath.row].description
                    self.addFromMarker(location: latLong, address: self.arrPlaces[indexPath.row].description, shortAddress: "")
                    break
                default:
                    self.toLatLong = latLong
                    self.txtToPlace.text = self.arrPlaces[indexPath.row].description
                    self.addToMarker(location: latLong, address: self.arrPlaces[indexPath.row].description, shortAddress: "")
                    self.btn_next.isHidden = false
                    self.btnGo.isEnabled = true
                    self.view.endEditing(true)
                    if self.fromLatLong != nil && self.toLatLong != nil {
                        //self.btnBackAction()
                        self.tablePlaces.isHidden = true
                        self.addMarkerAndDrawPloyline(from: self.fromLatLong, to: self.toLatLong)
                    }
                    break
                }
            }
        }
        tablePlaces.isHidden = true
    }
    
}

//// MARK: - Static Present VC
//extension SearchGoogleMapVC {
//    static func presentWith(delegate:SearchPlacesListVCDelegate,presenterVC:UIViewController,currentLatLong:CLLocationCoordinate2D?) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchPlacesListVC") as! SearchPlacesListVC
//        vc.providesPresentationContextTransitionStyle = true
//        vc.definesPresentationContext = true
//        vc.delegate = delegate
//        vc.currentLatLong = currentLatLong
//        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        presenterVC.present(vc, animated: false) {}
//    }
//}

