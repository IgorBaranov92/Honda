import UIKit

class OperationTableViewController: UITableViewController {

    private var percentage = [Int]()
    
    var consumption = Consumption()

    var operations = Operations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePercentage()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceList.intervals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "operationCell", for: indexPath)
        if let operationCell = cell as? OperationTableViewCell {
            operationCell.operationLabel.text = ServiceList.operations[indexPath.row]
            operationCell.percentageLabel.text = "\(percentage[indexPath.row]) %"
            switch percentage[indexPath.row] {
                case 0...80 : operationCell.percentageLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                case 81...100: operationCell.percentageLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                case 100...1000: operationCell.percentageLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            default: break
            }
            
            return operationCell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func calculatePercentage() {
        let currentMileage = consumption.allRecords.first!.mileage
        ServiceList.operations.forEach {
            let interval = ServiceList.intervals[$0]!
            let operaion = operations.getOperation($0)
            let distance = currentMileage - operaion.mileage
            let percent = Int(Double(distance)/(Double(interval))*100)
            percentage.append(percent)
        }
    }
}
