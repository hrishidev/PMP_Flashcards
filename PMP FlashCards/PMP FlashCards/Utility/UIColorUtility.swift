//
//  UIColorUtility.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 18/05/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import Foundation



enum ColorPalette : Int, CaseIterable {
    case  aqua 
    case  turquoise
    case  cerulean
    case  azure
    case  peach
    case  apricot
    case olive
    case navy
    case charcoal
    case silver
    case ivory /// with indigo text
    case black
    case pink
}

extension UIColor {
    
    class func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        var color = UIColor(red:(CGFloat((rgbValue & 0xFF0000) >> 16)/255.0), green: (CGFloat((rgbValue & 0x00FF00) >> 8)/255.0), blue: (CGFloat(rgbValue & 0x0000FF)/255.0), alpha: CGFloat(1.0))
        if #available(iOS 10.0, *) {
            color = UIColor(displayP3Red: (CGFloat((rgbValue & 0xFF0000) >> 16)/255.0), green: (CGFloat((rgbValue & 0x00FF00) >> 8)/255.0), blue: (CGFloat(rgbValue & 0x0000FF)/255.0), alpha: CGFloat(1.0))
        }
        return color

    }

    func darker(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func lighter(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by:  abs(percentage) )
    }
    
    func adjust(by percentage:CGFloat=30.0) -> UIColor? {
        
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }
    
    
class func primaryFor( selection : ColorPalette) -> UIColor {
        
        var primaryColor : UIColor
        
        switch selection {
            case .aqua:
                primaryColor = UIColor.hexStringToUIColor("#baecff")
            case .turquoise:
                primaryColor = UIColor.hexStringToUIColor("#40E0D0")
            case .cerulean:
                primaryColor = UIColor.hexStringToUIColor("#007ba7")
            case .azure:
                primaryColor = UIColor.hexStringToUIColor("#007fff")
            case .peach:
                primaryColor = UIColor.hexStringToUIColor("#ffe5b4")
            case .apricot:
                primaryColor = UIColor.hexStringToUIColor("#ffe5b4")
            case .olive:
                primaryColor = UIColor.hexStringToUIColor("#808000")
            case .navy:
                primaryColor = UIColor.hexStringToUIColor("#000080")
            case .charcoal:
                primaryColor = UIColor.hexStringToUIColor("#808080")
            case .silver:
                primaryColor = UIColor.hexStringToUIColor("#c0c0c0")
            case .ivory:
                primaryColor = UIColor.hexStringToUIColor("#fffff0")
            case .pink:
                primaryColor = UIColor.hexStringToUIColor("#ffc0cb")
        case .black:
                primaryColor = UIColor.black
    }

        return primaryColor
    }
    
    class func secondaryColor( selection : ColorPalette) -> UIColor {
        return UIColor.white
    }
    
    class func textColor ( selection : ColorPalette) -> UIColor {
        return UIColor.darkText
        
        
        // ivory  indigo
        // black  white
        // navy   white / ivory
//       return UIColor.lightText
    }
}
