import UIKit
import Realm
import RealmSwift


class ConsumptionViewController: UIViewController, AddDataDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet private weak var mileageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView! { didSet {
        containerView.alpha = 0.7
    }}
    
    var consumption = Consumption()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAverage()
    }
        
    // MARK: - TableView datasourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consumption.allRecords.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return true
        }
        return false
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            consumption.delete(at: indexPath.row)
            tableView.reloadData()
            updateAverage()
        }
    }
    
    func addDataWith(mileage: Int, litrage: Double, place: String, tripType: String, petrolType: String) {
        let difference = mileage - consumption.allRecords.first!.mileage
        let realConsumption = (Double(litrage))/Double(difference) * 100
        consumption.append(Record(mileage: mileage, consumption: realConsumption, date: Date.stringFromDate(), litrage: litrage, petrol: petrolType, place: place, type: tripType))
        tableView.reloadData()
        updateAverage()
        cancel()
    }
    
    func cancel() {
        AppearenceAnimator.dismiss(mileageView) {
            self.containerView.isHidden = true
        }
    }

    private var mileageView = MileageView()
    
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        mileageView = MileageView.initFromNib()
        mileageView.delegate = self
        view.addSubview(mileageView)
        containerView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        containerView.isHidden = false
        Constraints.activate(mileageView, view)
        AppearenceAnimator.show(mileageView)
    }
    
    private func updateAverage() {
        let total = consumption.allRecords.count
        let totalConsumption = consumption.allRecords.reduce(0) { $0 + $1.consumption }
        var avgConsumption = totalConsumption/Double(total)
        navigationItem.title = "Расход(\(avgConsumption.roundedByOne()))"
        let currentConsumption = consumption.allRecords.first!.consumption
        let currentMileage = consumption.allRecords.first!.mileage
        let realTimeAVG = (avgConsumption + currentConsumption)/2
        let nextMileage = currentMileage + Int((50.0/realTimeAVG * 100))
        mileageLabel.text = "\(nextMileage)"
    }

    
}
