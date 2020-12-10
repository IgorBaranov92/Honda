import UIKit
import CoreData

class ConsumptionTableViewController: UITableViewController , NSFetchedResultsControllerDelegate , AddDataDelegate  {

    @IBOutlet private weak var mileageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAverageConsumption()
        calculateService()
    }

 
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert : tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete : tableView.deleteRows(at: [indexPath!], with: .fade)
        default:break
        }
    }
    
    
    lazy var fetchedResultsController : NSFetchedResultsController<Mileage>? = {
        let request : NSFetchRequest<Mileage> = NSFetchRequest(entityName: "Mileage")
        request.sortDescriptors = [NSSortDescriptor(key:"mileage",ascending:false)]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: AppDelegate.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        try? aFetchedResultsController.performFetch()
        return aFetchedResultsController
    }()
    
    lazy var operationsfetchedResultsController : NSFetchedResultsController<Operation>? = {
        let request : NSFetchRequest<Operation> = NSFetchRequest(entityName: "Operation")
        request.sortDescriptors = [NSSortDescriptor(key:"mileage",ascending:false)]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: AppDelegate.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        try? aFetchedResultsController.performFetch()
        return aFetchedResultsController
    }()
    
    // MARK: - TableView datasourse
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections![0].numberOfObjects ?? 0
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "consumption", for: indexPath)
        if let myCell = cell as? ConsumptionTableViewCell {
            let mileage = fetchedResultsController?.object(at: indexPath)
            myCell.mileageLabel.text = "\(mileage!.mileage)"
            myCell.litrageLabel.text = mileage!.litrage.showIntegerIfPossible()
            myCell.pertolTypeLabel.text = "\(String(describing: mileage!.petrol!))"
            
            if indexPath.row == (fetchedResultsController?.sections![0].numberOfObjects)! - 1 || mileage!.consumption == 0 {
                myCell.consumptionLabel.isHidden = true
            } else {
                myCell.consumptionLabel.isHidden = false
                myCell.consumptionLabel.text = mileage!.consumption.roundedByOne().showIntegerIfPossible()
            }
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
    
    

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {[weak self] (action,indexPath) in
            let alert = UIAlertController(title: "Подтвержение", message: "Вы действительно хотите удалить эту заправку", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
            let doneAction = UIAlertAction(title: "Да", style: .default) { (action) in
                let object = self?.fetchedResultsController?.object(at: indexPath)
                AppDelegate.viewContext.delete(object!)
                try? AppDelegate.viewContext.save()
                self?.tableView.reloadData()
                self?.updateAverageConsumption()
                self?.calculateService()
            }
            alert.addAction(doneAction)
            alert.addAction(cancelAction)
            self?.present(alert, animated: true)
        }
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction]
    }
    
    
    func addDataWith(mileage: Int, litrage: Double, place: String?, tripType: String, petrolType: String, differenceMileage: Int) {
        let data = Mileage(context: AppDelegate.viewContext)
        data.mileage = Int64(mileage)
        data.litrage = Double(litrage)
        data.place = place
        data.type = tripType
        data.petrol = petrolType
        data.date = Date.stringFromDate()
        let realConsumption = (Double(litrage))/Double(differenceMileage) * 100
        data.consumption = realConsumption
        try? AppDelegate.viewContext.save()
        updateAverageConsumption()
        calculateService()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addData" {
            if let destinationVC = segue.destination as? AddDataViewController {
                if let object = fetchedResultsController?.sections![0].objects?.first as? Mileage {
                    destinationVC.lastMileage = Int(object.mileage)
                }
                destinationVC.delegate = self
            }
        }
        if segue.identifier == "viewData" {
            if let destinationVC = segue.destination as? ChangeDataViewController, let cell = sender as? ConsumptionTableViewCell,let index = tableView.indexPath(for: cell)?.row,let object = fetchedResultsController?.sections![0].objects?[index] as? Mileage {
                destinationVC.mileage = Int(object.mileage)
                destinationVC.place = object.place
                destinationVC.date = object.date ?? ""
                destinationVC.litrage = object.litrage
            }
        }
    }
    
    // MARK: - Helper functions
    
    private func updateAverageConsumption() {
        var totalConsumption = 0.0
        var totalNumberOfFueling = 0
        if let numberOfObjects = fetchedResultsController?.sections![0].numberOfObjects {
            if numberOfObjects > 0 {
                for  i in 0...(fetchedResultsController?.sections![0].numberOfObjects)! - 1  {
                    let indexPath = IndexPath(row: i, section: 0)
                    let mileage = fetchedResultsController?.object(at: indexPath)
                    let consumption = mileage!.consumption
                    if consumption > 0.5 {
                        totalConsumption += consumption
                        totalNumberOfFueling += 1
                    }
                }
                var average = totalConsumption/Double(totalNumberOfFueling)
                navigationItem.title = "Расход(\(average.roundedByOne().showIntegerIfPossible()))"
                if let object = fetchedResultsController?.sections![0].objects?.first as? Mileage {
                    let lastMileage = Int(object.mileage)
                    let lastConsumption = object.consumption
                    let avgConsumption = (lastConsumption + average)/2
                    let amount = 50.0/avgConsumption
                    let newMileage = lastMileage + Int(amount*100)
                    mileageLabel.text = String(newMileage)
                }
            }
        }
    }
    
    private func calculateService() {
        UserDefaults.standard.set(nil, forKey: "Operations")
        var operations = [String]()
        var alreadyChecked = [String]()
        if operationsfetchedResultsController?.sections![0].numberOfObjects != 0 {
            if let count = operationsfetchedResultsController?.sections![0].numberOfObjects {
                for index in 0..<count {
                    if let type = operationsfetchedResultsController?.object(at: IndexPath(row: index, section: 0)).type, let mileage = operationsfetchedResultsController?.object(at: IndexPath(row: index, section: 0)).mileage {
                        if !operations.contains(type) {
                            if let interval = ServiceList.intervals[type], let lastMileage = fetchedResultsController?.object(at: IndexPath(row: 0, section: 0)).mileage {
                                    if ( Int(lastMileage) >= Int(mileage) + interval ) && !alreadyChecked.contains(type) {
                                        operations.append(type)
                                    }else {
                                        alreadyChecked.append(type)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if operations.count >= 1 {
            UserDefaults.standard.set(operations, forKey: "Operations")
            tabBarController?.tabBar.items?[1].badgeValue = "\(operations.count)"
        } else {
            tabBarController?.tabBar.items?[1].badgeValue = nil
        }
    }
    
}
