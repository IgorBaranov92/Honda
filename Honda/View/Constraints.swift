import Foundation
import UIKit

class Constraints {
    
    class func activate(_ v1: UIView,_ v2: UIView) {
        v1.translatesAutoresizingMaskIntoConstraints = false
        v1.topAnchor.constraint(equalTo: v2.topAnchor, constant: 70).isActive = true
        v1.centerXAnchor.constraint(equalTo: v2.centerXAnchor).isActive = true
        let width = v2.bounds.width - 20
        v1.widthAnchor.constraint(equalToConstant: width).isActive = true
        v1.heightAnchor.constraint(equalToConstant: width - 30).isActive = true
    }
    
}
