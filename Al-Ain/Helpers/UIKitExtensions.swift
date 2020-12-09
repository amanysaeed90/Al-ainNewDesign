//
//  UIKitExtensions.swift
//  EasyTipView
//
//  Created by Teodor Patras on 29/06/16.
//  Copyright © 2016 teodorpatras. All rights reserved.
//

import Foundation
import UIKit
// MARK: - UIBarItem extension -

extension UIBarItem {
    var view: UIView? {
        if let item = self as? UIBarButtonItem, let customView = item.customView {
            return customView
        }
        return self.value(forKey: "view") as? UIView
    }
}
extension UINavigationController {
    
    public func presentTransparentNavigationBar() {
//        navigationBar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
//        navigationBar.isTranslucent = true
//        navigationBar.shadowImage = UIImage()
//        setNavigationBarHidden(false, animated:true)
    }
      func setBackgroundImage(_ image: UIImage) {
        navigationBar.isTranslucent = true
        navigationBar.barStyle = .blackTranslucent

        let logoImageView = UIImageView(image: image)
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        view.insertSubview(logoImageView, belowSubview: navigationBar)
        NSLayoutConstraint.activate([
          logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
          logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
          logoImageView.topAnchor.constraint(equalTo: view.topAnchor),
          logoImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
      }
    
    
    
    public func hideTransparentNavigationBar() {
        setNavigationBarHidden(true, animated:false)
        navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
        navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
        navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
    }
}

// MARK:- UIView extension -

extension UIView {
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
    func hasSuperview(_ superview: UIView) -> Bool{
        return viewHasSuperview(self, superview: superview)
    }
    
    fileprivate func viewHasSuperview(_ view: UIView, superview: UIView) -> Bool {
        if let sview = view.superview {
            if sview === superview {
                return true
            }else{
                return viewHasSuperview(sview, superview: superview)
            }
        }else{
            return false
        }
    }
}

// MARK:- CGRect extension -

extension CGRect {
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        
        set {
            self.origin.y = newValue
        }
    }

    
    var center: CGPoint {
        return CGPoint(x: self.x + self.width / 2, y: self.y + self.height / 2)
    }
}
extension String {
    func capturedGroups(withRegex pattern: String) -> [String] {
        var results = [String]()
        
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.characters.count))
        
        for match in matches {
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }
        
        for i in 1...lastRangeIndex {
            let capturedGroupIndex = match.range(at: i)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }
        
        }
        return results
    }
    func hexStringToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
extension Date {
    func GetCurrentYear() -> String{
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date )
        return "\(year)"
    }
    
}
extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
extension UIDevice {
var iPhoneX: Bool {
    return UIScreen.main.nativeBounds.height == 2436
}
var iPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}
enum ScreenType: String {
    case iPhones_4_4S = "iPhone 4 or iPhone 4S"
    case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
    case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
    case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
    case iPhones_X_XS_11Pro = "iPhone X or iPhone XS or iPhone 11 Pro"
    case iPhone_XR_11 = "iPhone XR or iphone11"
    case iPhone_XSMax_11ProMax = "iPhone XS Max or iphone 11 Pro Max"

    case unknown
}
var screenType: ScreenType {
    print(UIScreen.main.nativeBounds.height )
    switch UIScreen.main.nativeBounds.height {
    case 960:
        return .iPhones_4_4S
    case 1136:
        return .iPhones_5_5s_5c_SE
    case 1334:
        return .iPhones_6_6s_7_8
    case 1792:
        return .iPhone_XR_11
    case 1920, 2208:
        return .iPhones_6Plus_6sPlus_7Plus_8Plus
    case 2436:
        return .iPhones_X_XS_11Pro
    case 2688:
        return .iPhone_XSMax_11ProMax
    default:
        return .unknown
    }
}
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
extension UINavigationBar {

    var shadow: Bool {
        get {
            return false
        }
        set {
            if newValue {
//                self.layer.shadowOffset = CGSize(width: 0, height: 2)
//                self.layer.shadowColor = UIColor.black.cgColor
//                self.layer.shadowRadius = 3
//                self.layer.shadowOpacity = 0.5;
//                self.layer.masksToBounds = false
                if #available(iOS 13.0, *) {
                    navBarAppearance.shadowColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}
extension UIDevice {
  
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}
@available(iOS 13.0, *)
extension UIViewController{
    func setnavigationWhite_tintGray()
    {
        print("Header White")
        let image = UIImage(named: "1-small")
        navBarAppearance.backgroundImage = image
        navBarAppearance.backgroundColor = UIColor.white
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font:  UIFont(name: "DroidArabicKufi-Bold", size: 17)!]
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
//        navigationController?.navigationBar.layer.shadowOpacity = 1
//        navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
//        navigationController?.navigationBar.layer.shadowRadius = 2
//        navigationController?.navigationBar.layer.masksToBounds = false
//        let navbarImage = #imageLiteral(resourceName: "1-small").stretchableImage(withLeftCapWidth: 1, topCapHeight: 1)
//        
//        navigationController?.navigationBar.contentMode = .scaleAspectFit
//        navigationController?.navigationBar.setBackgroundImage(navbarImage, for: .default)
        
     
        
    }
    func setnavigationWhite()
    {
        print("Header White")
        let image = UIImage(named: "1-small")
        navBarAppearance.backgroundImage = image
        navBarAppearance.backgroundColor = UIColor.white
        
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font:  UIFont(name: "DroidArabicKufi-Bold", size: 17)!]
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
     
        
    }
    func setnavigationClear_tintWhite()
    {
        print("Header Clear")
        
        navBarAppearance.backgroundImage = UIImage()
        navBarAppearance.backgroundColor = UIColor.clear
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font:  UIFont(name: "DroidArabicKufi-Bold", size: 17)!]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        // Nav bar need sets to translucent for both nav bar and status bar to be translucent.
        // Need to reset nav bar's color to make it clear to display navBarAppearance's color
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        // Nav bar need sets to translucent for both nav bar and status bar to be translucent.
        // شفاف
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
//        navigationController?.navigationBar.layer.shadowOpacity = 0
//        navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
//        navigationController?.navigationBar.layer.shadowRadius = 0
//        navigationController?.navigationBar.layer.masksToBounds = true
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
       

    }
    
}
extension UITabBarItem{
    
    func SetImageInsets(){
        
        if (UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus || UIDevice.current.screenType == .iPhones_X_XS_11Pro ){
            if (UIDevice.modelName == "iPhone 11 Pro" )
            {
                self.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
            }
            else if (UIDevice.modelName == "iPhone 8 Plus" )
            {
                if #available(iOS 13, *) {
                    
                    self.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
                }
                else
                {
                    self.imageInsets = UIEdgeInsets(top: -4, left: 0, bottom: 4, right: 0)
                    
                }
            }
            else  if (UIDevice.modelName == "iPhone 6s" )
            {
                self.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
                
            }
            else if (UIDevice.modelName == "iPhone 6s Plus" )
                {
                self.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)

            }
            else if (UIDevice.modelName == "iPhone 7 Plus" )
            {
                self.imageInsets = UIEdgeInsets(top: 2.5, left: 0, bottom: -2.5, right: 0)

            
            }
            else if (UIDevice.modelName == "iPhone X" )
            {
                self.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)

            }
            else if (UIDevice.modelName == "iPhone XS" )
            {
                self.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)

            }
            else
            {
                
                self.imageInsets = UIEdgeInsets(top: -2, left: 0, bottom: 2, right: 0)
            }
        }
        else if (UIDevice.current.screenType == .iPhone_XSMax_11ProMax || UIDevice.current.screenType == .iPhones_6_6s_7_8)
        {
            if (UIDevice.modelName == "iPhone XS Max"){
                self.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)

            }
                    else if ( UIDevice.modelName == "iPhone 6s"  )
            {
                self.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
            }
         
            else if (UIDevice.modelName == "iPhone 6" )
            {
                self.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: 3, right: 0)
                
            }
            else  if (UIDevice.modelName == "iPhone 8" )
            {
                if #available(iOS 13, *) {
                    self.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
                }
                else
                {
                    self.imageInsets = UIEdgeInsets(top: -4, left: 0, bottom: 4, right: 0)
                }
                
            }
            else  if (UIDevice.modelName == "iPhone 7" )
            {
                self.imageInsets = UIEdgeInsets(top:3, left: 0, bottom: -3, right: 0)
                
            }
            else {
                self.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            }
        }
        else if ( UIDevice.current.screenType == .iPhone_XR_11 )
        {
            if (UIDevice.modelName == "iPhone XR" )
            {
                self.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
                
            }
            else {
                self.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            }
        }
        else if (UIDevice.current.screenType == .iPhones_5_5s_5c_SE)
        {
            self.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: 3, right: 0)
            
            
        }
        
        
        
    }
    func setTitlePositionAdjustment(){
        
        if (UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus || UIDevice.current.screenType == .iPhones_X_XS_11Pro ){
            
         if (UIDevice.modelName == "iPhone XS" )
         {
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: 3)
         }
         else if (UIDevice.modelName == "iPhone X" )
         {
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: 5)
         }
         
         else if (UIDevice.modelName == "iPhone 7 Plus" )
         {
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: -4)
         }
         else if (UIDevice.modelName == "iPhone 11 Pro" )
             {
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: 0)
         }
         else if (UIDevice.modelName == "iPhone 6s Plus" )
             {
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: -3)
         }
         else if (UIDevice.modelName == "iPhone 8 Plus" )
             {
             if #available(iOS 13, *) {
                 UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: -5)
                 
             } else {
                 // show sad face emoji
             }
          
         }
         else {
         UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
         }
             
         }
         else if (UIDevice.current.screenType == .iPhone_XSMax_11ProMax || UIDevice.current.screenType == .iPhones_6_6s_7_8)
         { if (UIDevice.modelName == "iPhone XS Max" )
         {
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: 4)
         }
         else  if (UIDevice.modelName == "iPhone 8" )
         {
          if #available(iOS 13, *) {
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: -5)
          }
          else{
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: 2)

             
          }
         }
         //iphone 11 Pro Max
         else  if (UIDevice.modelName == "iPhone 11 Pro Max" )
         {
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: 3)
        
         }

         else  if (UIDevice.modelName == "iPhone 7" )
         {
        
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: -4)

             
          
         }
         else  if (UIDevice.modelName == "iPhone 6s" )
         {
        
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: -3)

             
          
         }
         else  if (UIDevice.modelName == "iPhone 6" )
         {
        
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: 2)

             
          
         }
         else {
             
                         UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal:0, vertical: -5)
         }

             
             
         }
         else if ( UIDevice.current.screenType == .iPhone_XR_11 )
         {
             if (UIDevice.modelName == "iPhone XR" )
             {
                 UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 3)

             }
             else
             {
                 UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
             }
           
             
         }
         else if (UIDevice.current.screenType == .iPhones_5_5s_5c_SE)
         {
             
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
         }
         else
         {
             UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
             
         }
    }
}
extension String {
  func stringByRemovingOnce(chars: String) -> String {
    var cs = Set(chars.characters)
    let fd = characters.filter { c in
      cs.remove(c).map { _ in false } ?? true
    }
    return String(fd)
  }
}
