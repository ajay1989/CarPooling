//
//  DriverVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 29/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverVC: UIViewController {

    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var lbl_animate1: UILabel!
    @IBOutlet weak var lbl_animate2: UILabel!
    
    @IBOutlet weak var lbl_animate3: UILabel!
    
    @IBOutlet weak var lbl_animate4: UILabel!
    
    @IBOutlet weak var btnPublie: UIButton!{
        didSet{
            btnPublie.layer.shadowColor = UIColor.gray.cgColor
            btnPublie.layer.shadowOffset = CGSize(width: 0, height: 1)
            btnPublie.layer.shadowOpacity = 0.7
            btnPublie.layer.shadowRadius = 6.0
            btnPublie.layer.masksToBounds = false
            btnPublie.backgroundColor = UIColor.white
        }
    }
    var  timer: Timer = Timer()
    var  timer2: Timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
         timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(movingLabels), userInfo: nil, repeats: true)
         timer2 = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(movingLabels2), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        let url = URL(string: "\(ServiceUrls.profilePicURL)\(AppHelper.getValueForKey(ServiceKeys.profile_image)!)")!
        
        let placeholderImage = UIImage(named: "Male-driver")!
        
        self.img_User.af_setImage(withURL: url, placeholderImage: placeholderImage)

        //Otman
        
        print((AppHelper.getValueForKey(ServiceKeys.keyFirstName)!))
        
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name:
            "Montserrat", size: 17.0)! ]
        let nameStr = NSMutableAttributedString(string: AppHelper.getValueForKey(ServiceKeys.keyFirstName) as! String, attributes: myAttribute )
        let myString = NSMutableAttributedString(string: ", tu voyages quelque part? À plusieurs ćest", attributes: myAttribute )
        nameStr.append(myString)
        let attrString = NSMutableAttributedString(string: " mieux!")
        let myRange = NSRange(location: 1, length: 6)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(red: (193.0/255.0), green: (164.0/255.0), blue: (85.0/255.0), alpha: 1), range: myRange)
        nameStr.append(attrString)
        lblDes.attributedText = nameStr
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
        timer2.invalidate()
        
    }
    
    //MARK: Custom Action
    @IBAction func actionGoToStep1(sender: UIButton)
    {
        let driverStoryboard: UIStoryboard = UIStoryboard(name: "DriverStoryboard", bundle: nil)
        let driverStep1: DriverStep1VC = driverStoryboard.instantiateViewController(withIdentifier: "DriverStep1VC") as! DriverStep1VC
        self.navigationController?.pushViewController(driverStep1, animated: true)
       // self.present(driverStep1, animated: true, completion: nil)
    }
    
    @IBAction func ben_mesOffers_tap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:DriverRequestDetailsVC = storyboard.instantiateViewController(withIdentifier: "DriverRequestDetailsVC") as! DriverRequestDetailsVC
        // self.present(vc, animated: true, completion: nil)
        //mes demands passenger  mess offers driver
        vc.isFromDashboard = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func movingLabels()
{
    lbl_animate1.shake()
    
    lbl_animate3.shake()
   
    }
    @objc func movingLabels2()
    {
      
        lbl_animate2.shake()
       
        lbl_animate4.shake()
    }
}
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 1.0
        //[-20, 20, -20, 20, -10, 10, -5, 5, 0]
        animation.values = [-8, 8, -10, 10, -15, 15, -5, 5, 0]
        layer.add(animation, forKey: "shake")
    }
   
}
