//
//  DriverStep2VC.swift
//  CarPooling
//
//  Created by archit rai saxena on 01/12/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit
import GoogleMaps
class DriverStep2VC: BaseViewController,GMSMapViewDelegate {
    @IBOutlet weak var vw_Search: UIView!{
        didSet{
           vw_Search.borderWithShadow(radius: 6.0)
        }
    }
     var camera = GMSCameraPosition()
    @IBOutlet weak var mapViewer: GMSMapView!
    var ride:Ride!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ride.from_city)
        print(ride.from_city_lat)
        // Do any additional setup after loading the view.
        
        self.camera = GMSCameraPosition.camera(withLatitude: Double(ride.from_city_lat)!,
                                               longitude: Double(ride.from_city_lng)!, zoom: 18.0)
        
        
        mapViewer.camera = self.camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(ride.from_city_lat)!, longitude: Double(ride.from_city_lng)!)
        marker.title = "Destination address"
        marker.map = mapViewer
    }
    

    // MARK: - CustomAction method
    @IBAction func actionNext(sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let vc: DriverStep3VC = storyboard.instantiateViewController(withIdentifier: "DriverStep3VC") as! DriverStep3VC
        // self.present(vc, animated: true, completion: nil)
        vc.ride = self.ride
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

}
