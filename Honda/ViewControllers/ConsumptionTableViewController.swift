import UIKit
import Realm
import RealmSwift


class ConsumptionTableViewController: UITableViewController, AddDataDelegate  {

    @IBOutlet private weak var mileageLabel: UILabel!
    
    var consumption = Consumption()
    
   
    // MARK: - TableView datasourse
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consumption.allRecords.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "consumption", for: indexPath)
        if let myCell = cell as? ConsumptionTableViewCell {
            myCell.mileageLabel.text = "\(consumption.allRecords[indexPath.row].mileage)"
            myCell.litrageLabel.text = consumption.allRecords[indexPath.row].litrage.showIntegerIfPossible()
            myCell.pertolTypeLabel.text = "\(consumption.allRecords[indexPath.row].petrol)"
            var consumptionS = consumption.allRecords[indexPath.row].consumption
            myCell.consumptionLabel.text = consumptionS.roundedByOne().showIntegerIfPossible()
        }
        return cell
    }
    
    // MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return true
        }
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            consumption.delete(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func addDataWith(mileage: Int, litrage: Double, place: String, tripType: String, petrolType: String, differenceMileage: Int) {
        let realConsumption = (Double(litrage))/Double(differenceMileage) * 100
        consumption.append(Record(mileage: mileage, consumption: realConsumption, date: Date.stringFromDate(), litrage: litrage, petrol: petrolType, place: place, type: tripType))
        tableView.reloadData()
    }

    
}
