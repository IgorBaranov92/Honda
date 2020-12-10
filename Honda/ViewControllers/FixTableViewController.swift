import UIKit

class FixTableViewController: UITableViewController {

    var operations = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let operationList = UserDefaults.standard.value(forKey: "Operations") as? [String] {
            operations = operationList
        } 
    }

  // MARK: - TableView datasourse

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)
        if let myCell = cell as? FixTableViewCell {
            myCell.operationLabel.text = operations[indexPath.row]
        }
        

        return cell
    }
    
    
 
}
