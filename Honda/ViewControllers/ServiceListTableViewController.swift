import UIKit

class ServiceListTableViewController: UITableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ServiceList.categories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath)
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Segue {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addOperation"{
            if let destinationVC = segue.destination as? AddOperaionViewController {
                let indexPath = tableView.indexPathForSelectedRow!
                switch indexPath.section {
                case 0: destinationVC.currentTitle = ServiceList.engine[indexPath.row]
                case 1: destinationVC.currentTitle = ServiceList.transmisson[indexPath.row]
                case 2: destinationVC.currentTitle = ServiceList.suspension[indexPath.row]
                case 3: destinationVC.currentTitle = ServiceList.brakeSystem[indexPath.row]
                case 4: destinationVC.currentTitle = ServiceList.electric[indexPath.row]
                case 5: destinationVC.currentTitle = ServiceList.misc[indexPath.row]
                default:break
                }
            }
        }
    }
}
