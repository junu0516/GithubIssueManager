import UIKit

extension UIColor {
    
    static func rgbToColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
       return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
