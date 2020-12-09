//
//  Fonts.swift
//  El3een
//
//  Created by imac on 8/20/17.
//  Copyright © 2017 egygames. All rights reserved.
//

import Foundation
import UIKit

class Fonts{
    
    static func getFont(fontSize:CGFloat )-> UIFont    {
//        return UIFont(name: "DroidArabicKufi-Bold", size: fontSize)!
          return UIFont(name: "HelveticaNeueLTArabic-Bold", size: fontSize)!

     }
    static func getFontNormal(fontSize:CGFloat )-> UIFont    {
//           return UIFont(name: "DroidArabicKufi", size: fontSize)!
        return UIFont(name: "HelveticaNeue", size: fontSize)!

        }
    static func getFontSelected(fontSize:CGFloat )-> UIFont    {
        return UIFont(name: "HelveticaNeueLTArabic-Bold", size: fontSize)!
    }
    static func getFontWeb () -> UIFont    {
       return UIFont(name: "HelveticaNeueLTArabic-Bold", size: 15)!//DroidArabicNaskh
        
    }

}
