import UIKit

class AddOperaionViewController: UIViewController{

    // MARK: - Public API
    var operation = String() { didSet {
        operationLabel.text = operation
    }}
    
    weak var delegate: AddOperationDelegate?
    
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var mileageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var operationLabel: UILabel!
   
        
    // MARK: - Action
    @IBAction private func add(_ sender:UIBarButtonItem) {
        done()
    }
    
    private func done() {
        if infoTextField.text == "" || priceTextField.text == "" || mileageTextField.text == "" || operation == "" {
            let alert = UIAlertController(title: "Ошибка!", message: "Не заполнены все поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            delegate?.addOperationWith(mileage: Int(mileageTextField.text!)!, price: Int(priceTextField.text!)!, type: operation, info: infoTextField.text!)
            navigationController?.popViewController(animated: true)
        }
    }
}


extension AddOperaionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ServiceList.types.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceList.categories[ServiceList.types[section]]!.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ServiceList.types[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "operationCell", for: indexPath)
        if let myCell = cell as? ServiceListTableViewCell {
            myCell.detailLabel.text = ServiceList.categories[ServiceList.types[indexPath.section]]![indexPath.row]
            return myCell
        }

        return cell
    }
    
    // MARK: - TableView delegate

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        operation = ServiceList.categories[ServiceList.types[indexPath.section]]![indexPath.row]
    }
    
}
