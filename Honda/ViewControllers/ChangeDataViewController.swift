import UIKit

class ChangeDataViewController: UITableViewController , UITextFieldDelegate  {

    //MARK: Public API

    var mileage = 0
    var litrage = 0.0
    var place : String?
    var lastMileage = 0
    var date = ""


    //MARK: Outlets
    
    @IBOutlet weak var dateTextField: UITextField! { didSet { dateTextField.text = date } }

    @IBOutlet weak var placeTextField: UITextField! { didSet { placeTextField.text = place }}
    
    @IBOutlet weak var mileAgeTextField: NonPasteableTextField! {
        didSet {
            mileAgeTextField.text = String(mileage)
        }
    }
    @IBOutlet weak var litrageTextField: NonPasteableTextField! {
        didSet {
            litrageTextField.text = String(litrage.showIntegerIfPossible())
        }
    }

}


