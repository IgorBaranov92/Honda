import UIKit

class AddOperaionViewController: UIViewController{

    // MARK: - Public API
    var currentTitle = String()
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var mileageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
   
        
    // MARK: - Action
    @IBAction private func add(_ sender:UIBarButtonItem) {
        done()
    }
    
    private func done() {
        if infoTextField.text == "" || priceTextField.text == "" || mileageTextField.text == "" {
            let alert = UIAlertController(title: "Ошибка!", message: "Не заполнены все поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            
        }
    }
}


extension AddOperaionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ServiceList.categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return ServiceList.engine.count
        case 1: return ServiceList.transmisson.count
        case 2: return ServiceList.suspension.count
        case 3: return ServiceList.brakeSystem.count
        case 4: return ServiceList.electric.count
        case 5: return ServiceList.misc.count
        default: break
        }
        return 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Двигатель"
        case 1: return "АКПП"
        case 2: return "Подвеска"
        case 3: return "Тормозная система"
        case 4: return "Электрика"
        case 5: return "Разное"
        default: break
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "operationCell", for: indexPath)
        if let myCell = cell as? ServiceListTableViewCell {
            switch indexPath.section {
            case 0: myCell.detailLabel.text = ServiceList.engine[indexPath.row]
            case 1: myCell.detailLabel.text = ServiceList.transmisson[indexPath.row]
            case 2: myCell.detailLabel.text = ServiceList.suspension[indexPath.row]
            case 3: myCell.detailLabel.text = ServiceList.brakeSystem[indexPath.row]
            case 4: myCell.detailLabel.text = ServiceList.electric[indexPath.row]
            case 5: myCell.detailLabel.text = ServiceList.misc[indexPath.row]
            default:break
            }
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
    }
    
}
