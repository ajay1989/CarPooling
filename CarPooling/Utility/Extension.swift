//
//  Extension.swift
//  TradeInYourLease
//
//  Created by Sourabh Sharma on 10/4/17.
//  Copyright © 2017 Ajay Vyas. All rights reserved.
//



import Foundation
import UIKit
import GoogleMaps

//MARK:- Storyboard @IBInspectable set cornerRadius, borderWidth, borderColor


extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func addBackground(str:String) {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: str)
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
    
    func startShimmering(){
        let light = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.7).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, light, alpha, alpha, light, alpha]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.4, 0.5, 0.6]
        self.layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.5
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }
    
    func stopShimmering(){
        self.layer.mask = nil
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x : 0.0, y : 0.5)
        gradient.endPoint = CGPoint(x :1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    func borderWithShadow(radius: CGFloat)
    {
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.backgroundColor = UIColor.white
    }
}

extension UIImageView {
    
}


extension UITextField {
    func setBottomBorder() {
        
        self.borderStyle = UITextField.BorderStyle.none;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    func modifyClearButton() {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(named : "img_clear"), for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(UITextField.clear(_:)), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
    }
    
    @objc func clear(_ sender : AnyObject) {
        self.text = ""
        
//        sendActions(for: .editingChanged)
    }
    
    func decreaseFontSize () {
        self.font =  UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)!-2)!
    }
    func addPlaceholderSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: self.placeholder!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: self.placeholder!.characters.count))
        self.attributedPlaceholder = attributedString
    }
}

extension UILabel {
    func decreaseFontSize () {
        self.font =  UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)!-5)!
    }
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: self.text!.characters.count))
        self.attributedText = attributedString
    }
}


extension UITextView {
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: self.text!.characters.count))
        self.attributedText = attributedString
    }
    
    
}


extension Date {
    
    //MARK:- Date Foramatter
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from:self)
    }
    
    //MARK:- Calculate Age
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    func nearestHour() -> Date? {
        var components = NSCalendar.current.dateComponents([.minute], from: self)
        let minute = components.minute ?? 0
        components.minute = minute >= 30 ? 60 - minute : -minute
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var mnth: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != mnth
    }
}


//MARK:- Validation Extension -

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    func size(_ font: UIFont) -> CGSize {
        return NSAttributedString(string: self, attributes: [.font: font]).size()
    }
    
    func width(_ font: UIFont) -> CGFloat {
        return size(font).width
    }
    
    func height(_ font: UIFont) -> CGFloat {
        return size(font).height
    }
    
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            print_debug(trimmed.isEmpty)
            return trimmed.isEmpty
        }
    }
    var trim : String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    var isEmptyOrWhitespace : Bool {
        
        if(self.isEmpty) {
            return true
        }
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
        
    }
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
            0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
    
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
    
    
    func stringHeightWith(_ font:UIFont,width:CGFloat)->CGFloat
    {
        let size = CGSize(width: width,height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping;
        let  attributes = [NSAttributedString.Key.font:font,
                           NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    var isNumeric: Bool {
            guard self.characters.count > 0 else { return false }
            let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            return Set(self.characters).isSubset(of: nums)
        }
    var isAlphabetic: Bool {
        guard self.characters.count > 0 else { return false }
        let nums: Set<Character> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        return Set(self.characters).isSubset(of: nums)
    }
    
    
}

extension UITableView {
    func setOffsetToBottom(animated: Bool) {
        
        self.setContentOffset(CGPoint(x: 0, y: self.contentSize.height - self.frame.size.height), animated: true)
    }
    
    func scrollToLastRow(animated: Bool) {
        
        if self.numberOfRows(inSection: 0) > 0 {
            
            let index = IndexPath(row: self.numberOfRows(inSection: 0) - 1, section: 0)
            
            self.scrollToRow(at: index, at: .bottom, animated: true)
            //self.scrollToRowAtIndexPath(NSIndexPath(forRow: self.numberOfRowsInSection(0) - 1, inSection: 0), atScrollPosition: .Bottom, animated: animated)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}


extension UIButton{
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.characters.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}


extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector , myCancel :Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        cancelButton.tag = 1
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: myCancel)
        doneButton.tag = 2
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if(UIScreen.main.bounds.height == 812) {
            sizeThatFits.height = (UIScreen.main.bounds.height*11.5)/100 // adjust your size here
        }
        else {
            sizeThatFits.height = (UIScreen.main.bounds.height*9.5)/100 // adjust your size here
        }
        
        
        return sizeThatFits
    }
}
extension Dictionary {
    var prettyPrintedJSON: String? {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch _ {
            return nil
        }
    }
}
extension GMSMapView {
    func addMarker(location : CLLocationCoordinate2D, address : String, shortAddress : String) {
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude,longitude: location.longitude, zoom: 13.0)
        self.animate(to: camera)
        
        let marker = GMSMarker()
        let markerImage = UIImage(named: "Start-pin-icon.png")!.withRenderingMode(.alwaysTemplate)
        
        //creating a marker view
        let markerView = UIImageView(image: markerImage)
        markerView.tintColor = UIColor.clear
        
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.title = address
        marker.snippet = shortAddress
       // marker.iconView = markerView
        marker.map = self
    }
    
    func showPath(polyStr :String) {
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = kPolyLineStrokeColor
        polyline.map = self
    }
}




