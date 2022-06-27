import UIKit

extension UIColor {
    
    var contrast: UIColor {
        let ciColor = CIColor(color: self)
        
        let compRed: CGFloat = ciColor.red * 0.299
        let compGreen: CGFloat = ciColor.green * 0.587
        let compBlue: CGFloat = ciColor.blue * 0.114

        let luminance = (compRed + compGreen + compBlue)

        let col: CGFloat = luminance < 0.55 ? 1 : 0

        return UIColor( red: col, green: col, blue: col, alpha: ciColor.alpha)
    }
    
    static func rgbToColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
       return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
