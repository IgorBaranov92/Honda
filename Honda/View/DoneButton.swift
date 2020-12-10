import UIKit

@IBDesignable
class DoneButton: UIButton {

    @IBInspectable
    var color: UIColor = .red { didSet { setNeedsDisplay()}}
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 6)
        color.setFill()
        path.fill()
    }

}
