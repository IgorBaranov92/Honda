import UIKit

class RoundedView: UIView {

    @IBInspectable
    var color: UIColor = .red { didSet { setNeedsDisplay() }}
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 8)
        color.setFill()
        path.fill()
    }
}
