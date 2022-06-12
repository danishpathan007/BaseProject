import Foundation
import UIKit

enum AssetsColor {
   case primaryColor
   case secondaryColor
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .primaryColor:
            return UIColor(named: "PrimaryColor") ?? UIColor.black
        case .secondaryColor:
            return UIColor(named: "SecondaryColor") ?? UIColor.black
        }
    }
    
    
    class func colorWith(hexValue: UInt,alpha:CGFloat = 1) -> UIColor {
        return UIColor(
            red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    class func hexStringToUIColor (hex:String) -> UIColor {
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
    class func customBlueColor() -> UIColor{
        return UIColor(red: 72/255, green: 146/255, blue: 229/255, alpha: 1)
    }
    
    class func customGreenColor() -> UIColor{
        return UIColor(red: 85/255, green: 136/255, blue: 61/255, alpha: 1)
    }
    
    class func normalButtonColor() -> UIColor{
        return UIColor(red: 112/256.0, green: 112/256.0, blue: 112/256.0, alpha: 1.0)
    }
    class func selectedButtonColor() -> UIColor{
        return UIColor(red: 91/256.0, green: 91/256.0, blue: 91/256.0, alpha: 1.0)
    }
    
    class func viewBackGroundColor() -> UIColor{
        return UIColor(red: 39/256.0, green: 39/256.0, blue: 51/256.0, alpha: 1.0)
    }
    
    class func lighGreenColor() -> UIColor {
        return hexStringToUIColor(hex: "#7CC090")
    }
    
    class func greenColor() -> UIColor {
        return hexStringToUIColor(hex: "#249646")
    }
    
    class func yellowColor() -> UIColor {
        return hexStringToUIColor(hex: "#E8C924")
    }
    
    class func lightYellowColor() -> UIColor {
        return hexStringToUIColor(hex: "#F1DF7C")
    }
    
    class func redColor() -> UIColor {
        return hexStringToUIColor(hex: "#E32626")
    }
    
    class func lightRedColor() -> UIColor {
        return hexStringToUIColor(hex: "#EE7D7D")
    }
    
}
