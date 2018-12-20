//
//  HomeVC.swift
//  TabBarTest
//
//  Created by Archit Rai Saxena on 11/19/18.
//  Copyright © 2018 Archit. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet  var arrButtons: [UIButton]!
    var selectedIndex:NSInteger = 0
    
    weak  var currentViewController: UIViewController!
    var transitionInProgress: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeSelectionOfButton()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !(self.currentViewController != nil)
        {
            startUpAction()
        }
    }
    func startUpAction()
    {
        let Obj:UIViewController = getViewController()
        
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            Obj.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-110)
        }
        else
        {
            
            Obj.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-60)
        }
        Obj.view.layoutIfNeeded()
        self.addChild(Obj)
        Obj.didMove(toParent: self)
        self.view.addSubview(Obj.view)
        self.currentViewController = Obj
        
    }
    func changeSelectionOfButton()
    {
        
        for btn in arrButtons
        {
            print(btn.tag)
            if btn.tag == selectedIndex
            {
                btn.isSelected = true
            }
            else
            {
                btn.isSelected = false
            }
        }
    }
    
    
    func getViewController()->UIViewController
    {
        switch selectedIndex {
        case 0:
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let dashboardVc: DashboardVC = mainStoryboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            return dashboardVc
            
            
            break
        case 1:
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let driverVC: DriverVC = mainStoryboard.instantiateViewController(withIdentifier: "DriverVC") as! DriverVC
            return driverVC
            
            break
        case 3:
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let infoVC: InfoVC = mainStoryboard.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
            return infoVC
            
            break
            
        default:
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let dashBoardVC: DashboardVC = mainStoryboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            return dashBoardVC
            
            break
            
            
        }
    }
    
    func swipeFromViewController(fromViewController: UIViewController, toViewController: UIViewController)
    {
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            //iPhone X
            
            toViewController.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-110)
        }
        else
        {
            toViewController.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-60)
        }
        
        fromViewController.willMove(toParent: nil)
        self.addChild(toViewController)
        self.transition(from: fromViewController, to: toViewController, duration: 0.3, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: { (Bool)-> Void in
            fromViewController.removeFromParent()
            toViewController.didMove(toParent: self)
            self.currentViewController = toViewController
            self.transitionInProgress = false
            
        })
        
        
    }
    
    // MARK: Action method
    @IBAction func tabButtonAction(sender: UIButton)
    {
        
        if sender.tag != selectedIndex
        {
            selectedIndex = sender.tag
            changeSelectionOfButton()
            switch selectedIndex
            {
            case 0:
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dashboardVC: DashboardVC = mainStoryboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
                swipeFromViewController(fromViewController: self.currentViewController, toViewController: dashboardVC)
                
                break
                
            case 1:
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let driverVC: DriverVC = mainStoryboard.instantiateViewController(withIdentifier: "DriverVC") as! DriverVC
                swipeFromViewController(fromViewController: self.currentViewController, toViewController: driverVC)
                break
                
            case 2:
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let infoVC: InfoVC = mainStoryboard.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
                swipeFromViewController(fromViewController: self.currentViewController, toViewController: infoVC)
                break
                
            default:
                break
                
            }
            
        }
    }
}
