//
//
//  Created by Narottam on 02/04/18.
//  Copyright © 2017 Mac102. All rights reserved.
//

import UIKit
import Foundation
import SVProgressHUD

extension FloatingPoint {
    var toRadians: Self { return self * .pi / 180 }
    var toDegrees: Self { return self * 180 / .pi }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x:(labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x : locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y : locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }
    
    @IBInspectable var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.DescriptiveName,
                    newValue as NSString?,
                    objc_AssociationPolicy(rawValue: UInt(0))!
                )
            }
        }
    }
}

extension UIColor{
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
   
    
    public static let ciRed = UIColor(red: 0.8235294118,
                                      green: 0,
                                      blue: 0,
                                      alpha: 1)
    
    public static let ciGreen = UIColor(red: 0.2392156863,
                                        green: 0.6901960784,
                                        blue: 0.07843137255,
                                        alpha: 1)
    
    public static let ciOrange = UIColor(red: 1,
                                         green: 0.6784313725,
                                         blue: 0.1215686275,
                                         alpha: 1)
    
    public static let ciLightGray = UIColor(red: 0.3019607843,
                                            green: 0.3019607843,
                                            blue: 0.3019607843,
                                            alpha: 1)
    
    public static let ciGray = UIColor(red: 0.2416678667,
                                       green: 0.2418802977,
                                       blue: 0.2417007387,
                                       alpha: 1)
    
    public static let ciHighlight = UIColor(red: 0.02352941176,
                                            green: 0.3254901961,
                                            blue: 0.7137254902,
                                            alpha: 1)
}

extension CGColor{
    public static let ciRed = UIColor.ciRed.cgColor
    public static let ciGreen = UIColor.ciGreen.cgColor
    public static let ciOrange = UIColor.ciOrange.cgColor
    public static let ciGray = UIColor.ciGray.cgColor
    public static let ciHighlight = UIColor.ciHighlight.cgColor
}


extension UIView {
    
    @IBInspectable var layerCornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = false
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var shadowRadious: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue?.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
//    @IBInspectable var viewBorderColor:UIColor? {
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor:color)
//            }
//            else {
//                return nil
//            }
//        }
//    }
//
//    @IBInspectable var viewBorderWidth:CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
    
//    @IBInspectable var viewCornerRadius:CGFloat {
//        set {
//            layer.cornerRadius = newValue
//            clipsToBounds = newValue > 0
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
}

extension UIView{
    
    public func showHud(withText text: String = "Loading..."){
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
//        SVProgressHUD.show(withStatus: text)
        SVProgressHUD.show()

    }
    
    public func hideHud(){
        SVProgressHUD.dismiss()
    }
}

extension UIView{
    public func addSubviewWithConstraints(subview: UIView){
        addSubview(subview)
    }
}


extension CGRect{
    init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.init(x:x, y:y, width:width, height:height)
    }
}

extension CGSize{
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }
}

extension CGPoint{
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
}

extension UIView {
    func addShadowView() {
        //Remove previous shadow views
        superview?.viewWithTag(119900)?.removeFromSuperview()
        
        //Create new shadow view with frame
        let shadowView = UIView(frame: frame)
        shadowView.tag = 119900
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 3)
        shadowView.layer.masksToBounds = false
        
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.layer.shouldRasterize = true
        
        superview?.insertSubview(shadowView, belowSubview: self)
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}

extension UIImage{
    var fixed: UIImage?{
        if (imageOrientation == UIImage.Orientation.up ) { return self }
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(origin: .zero, size: size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copy
    }
    
    var base64String: String?{
        let strBase64 = compressedData?.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
    
    var compressedImage: UIImage?{
        return compressedData == nil ? nil : UIImage(data: compressedData!)
    }
    
    var compressedData: Data?{
        return self.jpegData(compressionQuality: 0.35)
    }
    
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}


extension UIScrollView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let nvc = self.window?.rootViewController as? UINavigationController{
            if let vc = nvc.visibleViewController{
                vc.touchesBegan(touches, with: event)
            }
        }
    }
}


@IBDesignable
extension UITextField {
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = UIFont(name: "Helvetica", size: 13.0)//self.font
        placeholderLabel.textColor = UIColor(red: 199/255, green: 199/255, blue: 205/255, alpha: 1.0)//.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}



extension UITextField
{
    func changeColorOfPertiularCharacter(text : String)
    {
        let underlineAttString = NSMutableAttributedString(string: text)
        let rang1 = (text as NSString).range(of: "*")
        underlineAttString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: rang1)
        self.attributedPlaceholder = underlineAttString
    }
}
extension UILabel
{
    func changeColorOfPertiularCharacterLabel(text : String,character : String)
    {
        let range = (text as NSString).range(of: character)
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.attributedText = attributedString
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    func roundedValue() -> String {
        print(String(format: "%.3f", self))
        return String(format: "%.3f", self)
    }
    
    func roundedDoubleValue(_ value : Int) -> String {
        print(String(format: "%.\(value)f", self))
        return String(format: "%.\(value)f", self)
    }
}



extension UITextView {
    
    
    func hyperLink(originalText: String, hyperLink: String, urlString: String) {
        
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSMakeRange(0, attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: fullRange)
        // attributedOriginalText.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 10), range: fullRange)
        
        self.linkTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([
            kCTForegroundColorAttributeName: UIColor.blue,
            kCTUnderlineStyleAttributeName: NSUnderlineStyle.single.rawValue,
            ] as [String : Any])
        
        
        self.attributedText = attributedOriginalText
    }
}

/// Exchange the implementation of two methods of the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
