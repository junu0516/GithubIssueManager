import UIKit

final class PaddingLabel: UILabel {
    
    var padding: UIEdgeInsets = .zero
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
    
    override func drawText(in rect: CGRect) {
        let paddingRect = rect.inset(by: padding)
        super.drawText(in: paddingRect)
    }
}
