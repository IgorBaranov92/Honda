import UIKit

class ServiceStatisticTableViewController: UITableViewController {

    var percentage = [Int]()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceList.intervals.keys.sorted().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statistic", for: indexPath)
        if let myCell = cell as? ServiceStatisticTableViewCell {
            myCell.serviceNameLabel.text = ServiceList.intervals.keys.sorted()[indexPath.row]
          //  myCell.percentageLabel.text = String(percentage[indexPath.row]) + "%"
        }

        return cell
    }
    


}
