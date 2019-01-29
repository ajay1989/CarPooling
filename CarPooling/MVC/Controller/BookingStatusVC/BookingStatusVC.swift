//
//  BookingStatusVC.swift
//  CarPooling
//
//  Created by Archit Rai Saxena on 16/01/19.
//  Copyright © 2019 Ajay Vyas. All rights reserved.
//
/*
 0-wating,1-approve,2-cancel,3-start,4-
 */
import UIKit

class BookingStatusVC: UIViewController {

    @IBOutlet weak var vw_contact: UIView!
    
    @IBOutlet weak var btn_Contact: UIButton!
    
    @IBOutlet weak var btn_demade: UIButton!
    
    @IBOutlet weak var ct_vwContactBottom: NSLayoutConstraint!
    
    @IBOutlet weak var vw_contactShadow: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
vw_contact.isHidden = true
        vw_contactShadow.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.black, radius: 0, opacity: 0.35)
        // Do any additional setup after loading the view.
    } 
    

  
    // MARK: - ActionMethod
    @IBAction func hideContactView()
    {
        hideView(view: vw_contact, hidden: true)
    }
    @IBAction func showContactView()
    {
        setView(view: vw_contact, hidden: false)
    }
    @IBAction func actionGoToBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func setView(view: UIView, hidden: Bool) {
        
        vw_contact.isHidden = false
        UIView.animate(withDuration: 1, delay: 0.3, options: [.curveEaseIn],
                       animations: {
                        self.vw_contact.center.y -= self.vw_contact.bounds.height
                        self.ct_vwContactBottom.constant = 0
                        self.vw_contact.layoutIfNeeded()
        }, completion: nil)
        
    }
    func hideView(view: UIView, hidden: Bool) {
        
        
        UIView.animate(withDuration: 1, delay: 0.3, options: [.curveEaseIn],
                       animations: {
                        self.vw_contact.center.y += self.vw_contact.bounds.height
                        self.ct_vwContactBottom.constant = -self.vw_contact.bounds.height
                        self.vw_contact.layoutIfNeeded()
        }, completion: nil)
        
    }

 

}
