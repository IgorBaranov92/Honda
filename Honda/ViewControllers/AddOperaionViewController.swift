import UIKit
import CoreData

class AddOperaionViewController: UITableViewController , UITextViewDelegate {

    // MARK: - Public API
    var currentTitle = String()
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var mileageTextField: UITextField!
    
    // MARK: - ViewController lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = currentTitle
        mileageTextField.becomeFirstResponder()
        addFirstToolbar()
        addSecondToolbar()
        addThirdToolbar()
    }
    
    // MARK: - Action
    @IBAction private func add(_ sender:UIBarButtonItem) {
        done()
    }
    
    // MARK: - Helper function
    
    private func addFirstToolbar() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 45)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let next = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(goToPriceTextField))
        toolbar.items = [space,next]
        mileageTextField.inputAccessoryView = toolbar
    }
    
    private func addSecondToolbar() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 45)
        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(goToMileageTextField))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let next = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(goToInfoTextField))
        toolbar.items = [back,space,next]
        priceTextField.inputAccessoryView = toolbar
    }
    
    private func addThirdToolbar() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 45)
        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(goToPriceTextField))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let next = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(done))
        toolbar.items = [back,space,next]
        infoTextField.inputAccessoryView = toolbar
    }
    
    
    @objc private func goToPriceTextField() {
        mileageTextField.resignFirstResponder()
        infoTextField.resignFirstResponder()
        priceTextField.becomeFirstResponder()
    }
    
    @objc private func goToInfoTextField() {
        priceTextField.resignFirstResponder()
        infoTextField.becomeFirstResponder()
    }
    
    @objc private func goToMileageTextField() {
        priceTextField.resignFirstResponder()
        mileageTextField.becomeFirstResponder()
    }
    
    
    @objc private func done() {
        if infoTextField.text == "" || priceTextField.text == "" || mileageTextField.text == "" {
            let alert = UIAlertController(title: "Ошибка!", message: "Не заполнены все поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let operation = Operation(context: AppDelegate.viewContext)
            operation.type = currentTitle
            operation.mileage = Int64(mileageTextField.text!)!
            operation.price = Int64(priceTextField.text!)!
            operation.info = infoTextField.text!
            try? AppDelegate.viewContext.save()
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
