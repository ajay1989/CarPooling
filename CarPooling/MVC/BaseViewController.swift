//
//  BaseViewController.swift
//  pikopako
//
//  Created by Ajay Vyas on 5/14/18.
//  Copyright © 2018 XtreemSolution. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast
///import SkeletonView

class BaseViewController: UIViewController {
    
    fileprivate var mScrollView : UIScrollView? = nil
    var tapGesture: UITapGestureRecognizer!
    var backButton = UIButton()
    var logOutButton = UIButton()
    var imageButtom = UIImageView()
    var rightView = UIView()
    var slideButton = UIButton()
    var slideImage = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 32))
        
        let widthConstraint = backButton.widthAnchor.constraint(equalToConstant: 60)
        let heightConstraint = backButton.heightAnchor.constraint(equalToConstant: 32)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        
        imageButtom = UIImageView(frame:CGRect(x: 0 , y: 6 , width: 18, height: 18))
        imageButtom.image = UIImage(named:"img_backBlack")
        let widthConstraint1 = imageButtom.widthAnchor.constraint(equalToConstant: 18)
        let heightConstraint1 = imageButtom.heightAnchor.constraint(equalToConstant:18)
        heightConstraint1.isActive = true
        widthConstraint1.isActive = true
        
        backButton.addSubview(imageButtom)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        
        backButton.addTarget(self, action: #selector(backButton(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        
        
        
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        let widthConstraint2 = rightView.widthAnchor.constraint(equalToConstant: 120)
        let heightConstraint2 = rightView.heightAnchor.constraint(equalToConstant: 32)
        heightConstraint2.isActive = true
        widthConstraint2.isActive = true
        self.slideButton = UIButton(frame: CGRect(x: 60, y: 0, width: 60, height: 32))
        let widthConstraint3 = slideButton.widthAnchor.constraint(equalToConstant: 60)
        let heightConstraint3 = slideButton.heightAnchor.constraint(equalToConstant: 32)
        heightConstraint3.isActive = true
        widthConstraint3.isActive = true
        slideImage = UIImageView(frame:CGRect(x: 38 , y: 8 , width: 22, height: 22))
        slideImage.image = UIImage(named:"img_notificationBell")
        let widthConstraint4 = slideImage.widthAnchor.constraint(equalToConstant: 22)
        let heightConstraint4 = slideImage.heightAnchor.constraint(equalToConstant: 22)
        heightConstraint4.isActive = true
        widthConstraint4.isActive = true
        self.slideButton.addSubview(slideImage)
        
        self.rightView.addSubview(self.slideButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightView)
        
        
        
    }
    
    func dateTimeFormateAccordingToUI(date:String,time:String)->String
    {
        //Archit..
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let date = dateformatter.date(from: date)
        dateformatter.dateFormat = "dd/MM/yyyy"
        let dateStr:String = dateformatter.string(from: date!)
        
        
        let dateformatter2 = DateFormatter()
        dateformatter2.dateFormat = "HH:mm:ss"
        let date2 = dateformatter2.date(from: time)
        dateformatter2.dateFormat = "hh'h'mm"
        let dateStr2:String = dateformatter2.string(from: date2!)
        return "le " + dateStr + " á " + dateStr2
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getAge(dob:String) -> Int {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthday: Date = dateFormatter.date(from:dob)!
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        return ageComponents.year!
    }
    
    @objc func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.endEditing(true)
        //
        //        if bgImage.image != ThemeManager.sharedInstance.backgroundImage {
        //            bgImage.image = ThemeManager.sharedInstance.backgroundImage
        //}
        
        // Add observer for keyborad Show/Hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // register scroll view
    func registerScrollView(_ scrollView : UIScrollView)
    {
        mScrollView = scrollView
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = true
        mScrollView?.addGestureRecognizer(tapGesture!)
        
        mScrollView?.showsVerticalScrollIndicator = false
        mScrollView?.showsHorizontalScrollIndicator = false
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    func makeToast(_ txt: String){
        self.view.hideToasts()
        self.view.makeToast(txt, duration: 1.5, position: "CSToastPositionCenter")
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // Remove observer for keybord Show/Hide
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    @objc func keyboardWillShow (notification : NSNotification)
    {
        
        if mScrollView == nil
        {
            return
        }
        
        if tapGesture == nil {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            // prevents the scroll view from swallowing up the touch event of child buttons
            tapGesture.cancelsTouchesInView = true
            mScrollView?.addGestureRecognizer(tapGesture)
            
            
        }
        
        // adjust screen size on appearing keyboard
        //   let kbSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        //        if let activeField = findFirstResponder(view: mScrollView!)
        //        {
        //            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize!.height, 0.0);
        //            mScrollView!.contentInset = contentInsets
        //            mScrollView!.scrollIndicatorInsets = contentInsets
        //
        //            var aRect = self.view.frame
        //            aRect.size.height -= kbSize!.height
        //            if (!aRect.contains(activeField.frame.origin) ) {
        //                mScrollView!.scrollRectToVisible(activeField.frame, animated: true)
        //            }
        //        }
        
        // adjust screen size on appearing keyboard
        //UIKeyboardFrameEndUserInfoKey
        var kbSize:CGRect!
        
        if #available(iOS 11.0, *) {
            kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        }else {
            kbSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        }
        
        if let activeField = findFirstResponder(view: mScrollView!)
        {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize!.height + 50, right: 0.0);
            mScrollView!.contentInset = contentInsets
            mScrollView!.scrollIndicatorInsets = contentInsets
            
            var aRect = self.view.frame
            if kbSize!.height == 0 {
                aRect.size.height -= 258
            }else {
                aRect.size.height -= kbSize!.height
            }
            
            if #available(iOS 11.0, *) {
                if (!aRect.contains(activeField.frame.origin) ) {
                    mScrollView!.scrollRectToVisible(activeField.frame, animated: true)
                }
                //                mScrollView!.scrollRectToVisible(aRect, animated: true)
            } else {
                if (!aRect.contains(activeField.frame.origin) ) {
                    mScrollView!.scrollRectToVisible(activeField.frame, animated: true)
                }
            }
        }
    }
    
    @objc func keyboardWillHide (notification : NSNotification)
    {
        if mScrollView == nil
        {
            return
        }
        if tapGesture != nil {
            mScrollView?.removeGestureRecognizer(tapGesture)
            tapGesture = nil
        }
        
        // adjust screen size on Hiding keyboard
        var contentInset = mScrollView!.contentInset
        contentInset.bottom = 0
        mScrollView!.contentInset = contentInset
        mScrollView!.scrollIndicatorInsets = contentInset
        
        
        
    }
    func findFirstResponder(view : UIView) -> UIView?
    {
        if view.isFirstResponder
        {
            return view
        }
        else
        {
            for subView in view.subviews
            {
                let responder: UIView? = findFirstResponder(view: subView )
                if responder != nil
                {
                    return responder
                }
            }
        }
        return nil
    }
    
    //hud show and hide
    
    func hudShow()  {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    func hudHide()  {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func transparentNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func hideNavigationController() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showNavigationController() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "img_bottomBackground"),for: .default)
        
        self.navigationController?.navigationBar.barTintColor  = CustomColor.nav_color
    }
    
    func setTitle(title:String) {
        self.title = title
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 14)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.pageTitleColor]
    }
    
    func addShadowToBar() {
        let shadowView = UIView(frame: self.navigationController!.navigationBar.frame)
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 0.4 // your opacity
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2) // your offset
        shadowView.layer.shadowRadius =  4 //your radius
        self.view.addSubview(shadowView)
    }
    
    func setupEntryField(field: [SkyFloatingLabelTextField]){
        for var i in 0..<field.count {
            field[i].placeholderColor = UIColor.white
            field[i].selectedTitleColor = .white
            field[i].lineColor = UIColor.white.withAlphaComponent(0.5)
            field[i].selectedLineColor = CustomColor.appThemeColor
            field[i].tintColor = .white
            field[i].textColor = .white
            field[i].font = UIFont(name: "Montserrat-SemiBold", size: 14)!
            field[i].autocorrectionType = UITextAutocorrectionType.no
            field[i].titleColor = .white
            field[i].titleFont = UIFont(name: "Montserrat-SemiBold", size: 12)!
            field[i].placeholderFont = UIFont(name: "Montserrat-SemiBold", size: 13)!
            if #available(iOS 9.0, *) {
                let item = field[i].inputAssistantItem
                item.leadingBarButtonGroups = []
                item.trailingBarButtonGroups = []
            }
        }
        
        
        
    }
    
    func setupEntryFieldLogin(field: [SkyFloatingLabelTextField]){
        for var i in 0..<field.count {
            field[i].placeholderColor = CustomColor.backgroundColorTheme
            field[i].selectedTitleColor = CustomColor.backgroundColorTheme
            field[i].lineColor = CustomColor.backgroundColorTheme.withAlphaComponent(0.5)
            field[i].selectedLineColor = CustomColor.appThemeColor
            field[i].tintColor = CustomColor.backgroundColorTheme
            field[i].textColor = CustomColor.backgroundColorTheme
            field[i].font = UIFont(name: "Montserrat-SemiBold", size: 14)!
            field[i].autocorrectionType = UITextAutocorrectionType.no
            field[i].titleColor = CustomColor.backgroundColorTheme
            field[i].titleFont = UIFont(name: "Montserrat-SemiBold", size: 12)!
            field[i].placeholderFont = UIFont(name: "Montserrat-SemiBold", size: 13)!
            if #available(iOS 9.0, *) {
                let item = field[i].inputAssistantItem
                item.leadingBarButtonGroups = []
                item.trailingBarButtonGroups = []
            }
        }
        
        
        
    }
    
    //    func showSkeletonView(view:UIView) {
    //
    //        for var view1 in view.subviews {
    //            view1.showAnimatedGradientSkeleton()
    //        }
    //    }
    //
    //    func hideSkeletonView(view:UIView) {
    //        for var view1 in view.subviews {
    //            view1.hideSkeleton()
    //        }
    //    }
    
    
    
    
    
}

