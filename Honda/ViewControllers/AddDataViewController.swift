import UIKit

class AddDataViewController: UITableViewController , UITextFieldDelegate , AddDataDelegate {

    weak var delegate : AddDataDelegate?
    
    @IBOutlet weak var petrolControl: UISegmentedControl!
    @IBOutlet weak var placeControl  : UISegmentedControl!
    @IBOutlet weak var mileAgeTextField: NonPasteableTextField!
    @IBOutlet weak var litrageTextField: NonPasteableTextField!
    
    var lastMileage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        litrageTextField.addTarget(self, action: #selector(changeLitrageTextField), for: .editingChanged)
        addToolBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mileAgeTextField.becomeFirstResponder()
    }
    
    @objc func changeLitrageTextField() {
        let string = litrageTextField.text
        let newString = string?.replacingOccurrences(of: ",", with: ".")
        litrageTextField.text = newString
    }

    
    @IBAction func checkData() {
        if mileAgeTextField.isEmpty() && litrageTextField.isEmpty() {
            showError(message: "Не заполнены обязательные поля")
        }

        else if mileAgeTextField.isNotEmpty() && litrageTextField.isNotEmpty() {
        let currentMileAge = Int64(mileAgeTextField.text!)!
        if currentMileAge < Int64(lastMileage)  {
            showError(message: "Текущий пробег не может быть меньше предудыщего!")
        }   else if litrageTextField.text! == "0" {
                showError(message: "Количество литров должно быть больше 0.")
        } else {
            addData()
            }
        }
    }
    
    private func addData() {
        let difference = Int(mileAgeTextField.text!)! - lastMileage
        delegate?.addDataWith(mileage: Int(mileAgeTextField.text!)!,
                              litrage: Double(litrageTextField.text!)!,
                              place: placeControl.titleForSegment(at: placeControl.selectedSegmentIndex)!,
                              tripType: "City",
                              petrolType: petrolControl.titleForSegment(at: petrolControl.selectedSegmentIndex)!,
                              differenceMileage: difference)
        dismissFromViewController()
    }


     private func showError(message:String) {
        let alert = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "," && textField == litrageTextField)  {
            if litrageTextField.isEmpty()  {
                showError(message: "Пустое поле")
            } else if litrageTextField.text?.last! == "." {
                showError(message: "Нельзя вводить 2 подряд .")
            }
        }
        return true
    }
    
    func addDataWith(mileage: Int, litrage: Double, place: String?, tripType: String, petrolType: String, differenceMileage: Int) {}
    
    
    private func addToolBar() {
        let frameForToolBar = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50)
        let plusButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(done))
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let toolBar = UIToolbar(frame: frameForToolBar)
        toolBar.items  = [flexibleSpaceItem,plusButtonItem]
        let move = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(moveToLitrage))
        let secondToolbar = UIToolbar(frame: frameForToolBar)
        secondToolbar.items = [flexibleSpaceItem,move]
        litrageTextField.inputAccessoryView = toolBar
        mileAgeTextField.inputAccessoryView = secondToolbar
    }
    
    @objc private func moveToLitrage() {
        mileAgeTextField.resignFirstResponder()
        litrageTextField.becomeFirstResponder()
    }
    
    @objc private func done() {
        checkData()
    }
    
    private func dismissFromViewController(){
        mileAgeTextField.resignFirstResponder()
        litrageTextField.resignFirstResponder()
        navigationController?.popToRootViewController(animated: true)
    }
  
}

extension UITextField {
    func isEmpty() -> Bool {
        if self.text == "" {
            return true
        }
        return false
    }
    func isNotEmpty() -> Bool {
        if self.text != ""  {
            return true
        }
        return false
    }
}
