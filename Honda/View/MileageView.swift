import UIKit

class MileageView: UIView, UITextFieldDelegate {

    weak var delegate: AddDataDelegate?
    
    @IBOutlet weak var petrolControl: UISegmentedControl!
    @IBOutlet weak var placeControl  : UISegmentedControl!
    @IBOutlet weak var mileAgeTextField: NonPasteableTextField!
    @IBOutlet weak var litrageTextField: NonPasteableTextField! { didSet {
        litrageTextField.delegate = self
        litrageTextField.addTarget(self, action: #selector(changeLitrageTextField), for: .editingChanged)
    }}

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "," && textField == litrageTextField)  {
            if litrageTextField.text == ""  {
                
            } else if litrageTextField.text?.last! == "." {
                
            }
        }
        return true
    }
    
    @objc func changeLitrageTextField() {
        let string = litrageTextField.text
        let newString = string?.replacingOccurrences(of: ",", with: ".")
        litrageTextField.text = newString
    }
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 8)
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        path.fill()
    }
  
    @IBAction func add(_ sender: DoneButton) {
        delegate?.addDataWith(mileage: Int(mileAgeTextField.text!)!, litrage: Double(litrageTextField.text!)!, place: placeControl.titleForSegment(at: placeControl.selectedSegmentIndex) ?? "", tripType: " ", petrolType: petrolControl.titleForSegment(at: petrolControl.selectedSegmentIndex) ?? "")
    }
    
    @IBAction func cancel(_ sender: DoneButton) {
        delegate?.cancel()
        litrageTextField.resignFirstResponder()
        mileAgeTextField.resignFirstResponder()
    }
    
}


extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)!.first as! T
    }
}
