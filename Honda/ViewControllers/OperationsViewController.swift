import UIKit
import Realm
import RealmSwift

class OperationsViewController: UITableViewController, AddOperationDelegate {
    
    var operations = Operations()

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "operationCell",for: indexPath)
        if let operationCell = cell as? ServiceTableViewCell {
            operationCell.operationLabel.text = operations.all[indexPath.row].type
            operationCell.mileageLabel.text = String(operations.all[indexPath.row].mileage)
            operationCell.infoLabeL.text = String(operations.all[indexPath.row].price) + " " + operations.all[indexPath.row].info
            return operationCell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            operations.delete(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func addOperationWith(mileage: Int, price: Int, type: String, info: String) {
        operations.add(OperationR(mileage: mileage, info: info, price: price, type: type))
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addOperation", let destination = segue.destination as? AddOperaionViewController {
            destination.delegate = self
        }
    }
}
