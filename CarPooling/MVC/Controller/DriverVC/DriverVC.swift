//
//  DriverVC.swift
//  CarPooling
//
//  Created by archit rai saxena on 29/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import UIKit

class DriverVC: UIViewController {

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
